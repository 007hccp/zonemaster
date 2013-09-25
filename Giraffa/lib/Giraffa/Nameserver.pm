package Giraffa::Nameserver v0.0.1;

use 5.14.2;
use Moose;
use Moose::Util::TypeConstraints;

use Giraffa::DNSName;
use Giraffa;
use Giraffa::Packet;

use Net::DNS;
use Net::IP;
use Time::HiRes qw[time];
use Storable qw[nstore retrieve];
use Module::Find qw[useall];
use Carp;

subtype 'Giraffa::Net::IP', as 'Object', where { $_->isa( 'Net::IP' ) };
coerce 'Giraffa::Net::IP', from 'Str', via { Net::IP->new( $_ ) };

has 'name'    => ( is => 'ro', isa => 'Giraffa::DNSName', coerce => 1, required => 0 );
has 'address' => ( is => 'ro', isa => 'Giraffa::Net::IP', coerce => 1, required => 1 );

has 'dns' => ( is => 'ro', isa => 'Net::DNS::Resolver', lazy_build => 1 );
has 'cache' => ( is => 'ro', isa => 'HashRef', default => sub { {} } );

###
### Variables
###

our %object_cache;

###
### Build methods for attributes
###

around 'new' => sub {
    my $orig = shift;
    my $self = shift;

    my $obj = $self->$orig( @_ );
    my $name = $obj->name;
    $name = '$$$NONAME' unless $name;

    if (not exists $object_cache{ '' . $name }{ $obj->address->ip }) {
        Giraffa->logger->add(NS_CREATED => {name => "$name", ip => $obj->address->ip});
        $object_cache{ '' . $name }{ $obj->address->ip } = $obj;
    }

    Giraffa->logger->add(NS_FETCHED => {name => "$name", ip => $obj->address->ip});
    return $object_cache{ '' . $name }{ $obj->address->ip };
};

sub _build_dns {
    my ( $self ) = @_;

    my $res = Net::DNS::Resolver->new(
        nameservers => [ $self->address->ip ],
        recurse     => 0,
        port        => 53,
        defnames    => 0,
        dnsrch      => 0,
    );

    my %defaults = %{ Giraffa->config->get->{resolver}{defaults} };
    foreach my $flag ( keys %defaults ) {
        $res->$flag( $defaults{$flag} );
    }

    return $res;
}

###
### Public Methods (and helpers)
###

sub query {
    my ( $self, $name, $type, $href ) = @_;
    $type //= 'A';

    Giraffa->logger->add( 'query', { name => "$name", type => $type, flags => $href, ip => $self->address->short } );

    my %defaults = %{ Giraffa->config->get->{resolver}{defaults} };

    my $class   = $href->{class}   // 'IN';
    my $dnssec  = $href->{dnssec}  // $defaults{dnssec};
    my $usevc   = $href->{usevc}   // $defaults{usevc};
    my $recurse = $href->{recurse} // $defaults{recurse};

    if ( not exists( $self->cache->{$name}{$type}{$class}{$dnssec}{$usevc}{$recurse} ) ) {
        $self->cache->{$name}{$type}{$class}{$dnssec}{$usevc}{$recurse} = $self->_query( $name, $type, $href );
    }

    return $self->cache->{$name}{$type}{$class}{$dnssec}{$usevc}{$recurse};
}

sub _query {
    my ( $self, $name, $type, $href ) = @_;
    my %flags;

    $type //= 'A';
    $href->{class} //= 'IN';

    if ( Giraffa->config->get->{no_network} ) {
        croak sprintf "External query for %s, %s attempted to %s while running with no_network", $name, $type, $self->string;
    }

    Giraffa->logger->add( 'external_query',
        { name => "$name", type => $type, flags => $href, ip => $self->address->short } );

    my %defaults = %{ Giraffa->config->get->{resolver}{defaults} };

    foreach my $flag ( keys %defaults ) {
        $flags{$flag} = $href->{$flag} // $defaults{$flag};
    }

    foreach my $flag ( keys %flags ) {
        $self->dns->$flag( $flags{$flag} );
    }

    my $res = eval { $self->dns->send( "$name", $type, $href->{class} ) };

    foreach my $flag ( keys %defaults ) {
        $self->dns->$flag( $defaults{$flag} );
    }

    if ( $res ) {
        return Giraffa::Packet->new( { packet => $res } );
    }
    else {
        return;
    }
}

sub string {
    my ( $self ) = @_;

    return $self->name->string . '/' . $self->address->short;
}

sub save {
    my ( $class, $filename ) = @_;

    return nstore \%object_cache, $filename;
}

sub restore {
    my ( $class, $filename ) = @_;

    useall 'Net::DNS::RR';
    %object_cache = %{ retrieve( $filename ) };

    return;
}

1;

=head1 NAME

Giraffa::Nameserver - object representing a DNS nameserver

=head1 SYNOPSIS

    my $ns = Giraffa::Nameserver->new({ name => 'ns.nic.se', address => '212.247.7.228' });
    my $p = $ns->query('www.iis.se', 'AAAA');

=head1 ATTRIBUTES

=over

=item name

A L<Giraffa::DNSName> object holding the nameserver's name.

=item address

A L<Net::IP> object holding the nameserver's address.

=item dns

The L<Net::DNS::Resolver> object used to actually send and recieve DNS queries.

=item cache

A reference to a hash holding the cache of sent queries. Not meant for external use.

=back

=head1 METHODS

=over

=item query($name, $type, $flagref)

Send a DNS query to the nameserver the object represents. C<$name> and C<$type> are the name and type that will be queried for (C<$type> defaults
to 'A' if it's left undefined). C<$flagref> is a reference to a hash, the keys of which are flags and the values are their corresponding values.
The available flags are as follows. All but the first directly correspond to methods in the L<Net::DNS::Resolver> object.

=over

=item class

Defaults to 'IN' if not set.

=item usevc

Send the query via TCP (only).

=item retrans

The retransmission interval

=item dnssec

Set the DO flag in the query.

=item debug

Set the debug flag in the resolver, producing output on STDERR as the query process proceeds.

=item recurse

Set the RD flag in the query.

=item udp_timeout

Set the UDP timeout for the outgoing UDP socket. May or may not be observed by the underlying network stack.

=item tcp_timeout

Set the TCP timeout for the outgoing TCP socket. May or may not be observed by the underlying network stack.

=item retry

Set the number of times the query is tried.

=item igntc

If set to true, incoming response packets with the TC flag set are not automatically retried over TCP.

=back

=item string()

Returns a string representation of the object. Normally this is just the name and IP address separated by a slash.

=item save($filename)

Save the entire object cache to the given filename, using the byte-order-independent Storable format.

=item restore($filename)

Replace the entire object cache with the contents of the named file.

=back

=cut
