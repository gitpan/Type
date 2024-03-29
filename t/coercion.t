use strict;
use warnings;
use encoding 'utf8';

use Test::Fatal;
use Test::More 0.88;

use Eval::Closure qw( eval_closure );
use Type::Declare;
use Type::Library::Builtins;

{
    my $arrayref = t('ArrayRef');

    ok(
        !$arrayref->has_coercions(),
        'ArrayRef type object does not have coercions'
    );

    ok(
        !Type::Library::Builtins::t('ArrayRef')->has_coercions(),
        'ArrayRef type in Type::Library::Builtins package does not have coercions'
    );

    coerce(
        $arrayref,
        from  => t('Int'),
        using => sub { [ $_[0] ] },
    );

    ok( $arrayref->has_coercions(), 'ArrayRef type object has coercions' );

    ok(
        !Type::Library::Builtins::t('ArrayRef')->has_coercions(),
        'ArrayRef type in Type::Library::Builtins package does not have coercions (coercions only apply to local copy of type)'
    );

    ok(
        $arrayref->has_coercion_from_type( t('Int') ),
        'has a coercion for the Int type'
    );

    ok(
        !$arrayref->has_coercion_from_type( t('Str') ),
        'does not have a coercion for the Str type'
    );

    is_deeply(
        $arrayref->coerce_value(42),
        [42],
        'coerced int to arrayref',
    );

    is(
        $arrayref->coerce_value(42.1),
        42.1,
        'cannot coerce num to arrayref - returns original value',
    );

    ok(
        !$arrayref->can_inline_coercion_and_check(),
        'cannot inline coercion and check for arrayref'
    );
}

{
    my $hashref = t('HashRef');

    coerce(
        $hashref,
        from             => t('ArrayRef'),
        inline_generator => sub {
            return '{ @{ ' . $_[1] . '} }';
        },
    );

    ok(
        $hashref->can_inline_coercion_and_check(),
        'can inline coercion and check for hashref'
    );

    coerce(
        $hashref,
        from             => t('Int'),
        inline_generator => sub {
            return '{ ' . $_[1] . ' => 1 }';
        },
    );

    ok(
        $hashref->can_inline_coercion_and_check(),
        'can inline coercion and check for hashref with two coercions'
    );

    my ( $source, $environment )
        = $hashref->inline_coercion_and_check('$_[0]');

    my $coerce_and_check;
    eval {
        $coerce_and_check = eval_closure(
            source      => 'sub { ' . $source . ' }',
            environment => $environment,
            description => 'inlined coerce and check sub',
        );
    };

    is(
        $@,
        q{},
        'no error evaling closure for coercion and check'
    );

    is_deeply(
        $coerce_and_check->( { x => 1 } ),
        { x => 1 },
        'hashref is passed through coerce and check unchanged'
    );

    is_deeply(
        $coerce_and_check->( [ x => 1 ] ),
        { x => 1 },
        'arrayref is coerced to hashref'
    );

    is_deeply(
        $coerce_and_check->(42),
        { 42 => 1 },
        'integer is coerced to hashref'
    );

    like(
        exception { $coerce_and_check->('foo') },
        qr/\QValidation failed for type named HashRef declared in package Type::Library::Builtins\E.+\Qwith value "foo"/,
        'string throws exception'
    );
}

{
    my $hashref = declare(
        'HashRef2',
        parent => t('HashRef'),
    );

    coerce(
        $hashref,
        from  => t('ArrayRef'),
        using => sub {
            return { @{ $_[0] } };
        },
    );

    coerce(
        $hashref,
        from  => t('Int'),
        using => sub {
            return { $_[0] => 1 };
        },
    );

    is_deeply(
        $hashref->coerce_value( [ x => 1 ] ),
        { x => 1 },
        'arrayref is coerced to hashref'
    );

    is_deeply(
        $hashref->coerce_value(42),
        { 42 => 1 },
        'integer is coerced to hashref'
    );

    is(
        $hashref->coerce_value('foo'),
        'foo',
        'cannot coerce num to arrayref - returns original value',
    );
}

{
    my $str = t('Str');

    like(
        exception {
            coerce(
                $str,
                from => t('Int'),
            );
        },
        qr/\QA type coercion must have either a coercion or inline_generator parameter/,
        'a coercion must have a coercion sub or an inline generator'
    );
}

done_testing();
