package Giraffa::CLI;

use 5.014002;
use warnings;

our $VERSION = '0.01';

use Moose;
with 'MooseX::Getopt';

use Giraffa;
use Giraffa::Logger::Entry;
use Giraffa::Translator;
use JSON::XS;

our %numeric = Giraffa::Logger::Entry->levels;
my $json = JSON::XS->new;

has 'level' => (
    is            => 'ro',
    isa           => 'Str',
    required      => 0,
    default       => 'NOTICE',
    documentation => 'The minimum severity level to display'
);

has 'lang' => (
    is            => 'ro',
    isa           => 'Str',
    required      => 0,
    default       => 'tech',
    documentation => 'The language to show messages in. Can be tech, raw, json or any installed translation.',
);

has 'time' => (
    is            => 'ro',
    isa           => 'Bool',
    documentation => 'Print timestamp on entries.',
    default       => 1,
);

has 'show_level' => (
    is            => 'ro',
    isa           => 'Bool',
    documentation => 'Print level on entries.',
    default       => 1,
);

has 'ns' => (
    is            => 'ro',
    isa           => 'ArrayRef',
    documentation => 'A name/ip string giving a nameserver for undelegated tests. Can be given multiple times.',
);

has 'ds' => (
    is  => 'ro',
    isa => 'ArrayRef',
    documentation =>
      'A DS record in presentation format for undelegated tests (not yet implemented). Can be given multiple times.'
);

has 'save' => (
    is            => 'ro',
    isa           => 'Str',
    required      => 0,
    documentation => 'Name of a file to save DNS data to after running tests.',
);

has 'restore' => (
    is            => 'ro',
    isa           => 'Str',
    required      => 0,
    documentation => 'Name of a file to restore DNS data from before running test.',
);

has 'ipv4' => (
    is => 'ro',
    isa => 'Bool',
    default => 1,
    documentation => 'Flag to permit or deny queries being sent via IPv4.',
);

has 'ipv6' => (
    is => 'ro',
    isa => 'Bool',
    default => 1,
    documentation => 'Flag to permit or deny queries being sent via IPv6.',
);

sub run {
    my ( $self ) = @_;
    my @accumulator;

    my ( $domain ) = @{ $self->extra_argv };
    if ( not $domain ) {
        die "Must give the name of a domain to test.\n";
    }

    Giraffa->config->get->{net}{ipv4} = $self->ipv4;
    Giraffa->config->get->{net}{ipv6} = $self->ipv6;

    my $translator;
    $translator = Giraffa::Translator->new( { lang => $self->lang } )
      unless ( $self->lang eq 'raw' or $self->lang eq 'json' );
    eval { $translator->data } if $translator;    # Provoke lazy loading of translation data
    if ( $@ ) {
        if ( $@ =~ /Cannot read translation file/ ) {
            say "Cannot find a translation for language " . $self->lang . ".";
            exit( 1 );
        }
        else {
            die "Oops: $@";
        }
    }

    if ( $self->restore ) {
        Giraffa->preload_cache( $self->restore );
    }

    # Callback defined here so it closes over the setup above.
    Giraffa->logger->callback(
        sub {
            my ( $entry ) = @_;

            return if $numeric{ uc $entry->level } < $numeric{ uc $self->level };

            if ( $translator ) {
                if ( $self->time ) {
                    printf "%7.2f ", $entry->timestamp;
                }

                if ( $self->show_level ) {
                    printf "%-9s ", $entry->level;
                }

                say $translator->translate_tag( $entry );
            }
            elsif ( $self->lang eq 'json' ) {
                push @accumulator,
                  {
                    timestamp => $entry->timestamp,
                    module    => $entry->module,
                    tag       => $entry->tag,
                    args      => $entry->args,
                  };
            }
            else {
                printf "%7.2f %-9s %s\n", $entry->timestamp, $entry->level, $entry->string;
            }
        }
    );

    if ( $translator ) {
        say 'Seconds Level     Message';
        say '======= ========= =======';
    }

    if ( $self->ns and @{ $self->ns } > 0 ) {
        $self->add_fake_delegation( $domain );
    }
    Giraffa->test_zone( $domain );

    if ( $self->lang eq 'json' ) {
        say $json->encode( \@accumulator );
    }

    if ( $self->save ) {
        Giraffa->save_cache( $self->save );
    }

    return;
} ## end sub run

sub add_fake_delegation {
    my ( $self, $domain ) = @_;
    my %data;

    foreach my $pair ( @{ $self->ns } ) {
        my ( $name, $ip ) = split( '/', $pair, 2 );
        push @{ $data{$name} }, $ip;
    }

    Giraffa->add_fake_delegation( $domain => \%data );

    return;
}

1;
