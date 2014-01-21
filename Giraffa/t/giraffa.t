use Test::More;

BEGIN { use_ok( 'Giraffa' ) }
BEGIN { use_ok( 'Giraffa::Test' ) }

isa_ok( Giraffa->logger, 'Giraffa::Logger' );
isa_ok( Giraffa->config, 'Giraffa::Config' );

is_deeply( [ sort Giraffa::Test->modules ], [qw(Consistency Delegation Syntax)] );

done_testing;
