use strict;
use warnings;
use encoding 'utf8';

use Test::More 0.88;

use Try::Tiny;
use Type::Library::Builtins;

{
    my $str = t('Str');

    my $e;
    try {
        $str->validate_or_die(undef);
    }
    catch {
        $e = $_;
    };

    ok( $e, 'validate_or_die throws something when given a bad value' );
    isa_ok( $e, 'Type::Exception' );

    like(
        $e->message(), qr/Validation failed for type named Str .+ with value undef/,
        'exception contains expected error'
    );

    try {
        $str->validate_or_die([]);
    }
    catch {
        $e = $_;
    };

    like(
        $e->message(), qr/Validation failed for type named Str .+ with value \[\s*\]/,
        'exception contains expected error'
    );
}

done_testing();
