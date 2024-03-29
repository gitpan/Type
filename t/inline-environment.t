use strict;
use warnings;
use encoding 'utf8';

use Test::Fatal;
use Test::More 0.88;

use Type::Constraint::Simple;
use Type::DeclaredAt;
use Type::Library::Builtins;

{
    my $t = Type::Constraint::Simple->new(
        name               => 'Foo',
        parent             => t('Str'),
        inline_generator   => sub { '1' },
        inline_environment => { '$scalar' => 42 },
        declared_at        => Type::DeclaredAt->new_from_caller(0),
    );

    my $from_int = Type::Coercion->new(
        from               => t('Int'),
        to                 => $t,
        inline_generator   => sub { '1' },
        inline_environment => {
            '%hash' => { y => 84 },
        },
        declared_at => Type::DeclaredAt->new_from_caller(0),
    );

    my $from_num = Type::Coercion->new(
        from               => t('Num'),
        to                 => $t,
        inline_generator   => sub { '1' },
        inline_environment => {
            '@array' => [ 1, 2, 3 ],
        },
        declared_at => Type::DeclaredAt->new_from_caller(0),
    );

    $t->add_coercion($from_int);
    $t->add_coercion($from_num);

    my ( $code, $env ) = $t->inline_coercion_and_check('$var');

    my %expect = (
        '$scalar' => 42,
        '%hash'   => { y => 84 },
        '@array'  => [ 1, 2, 3 ],
    );

    for my $key ( sort keys %expect ) {
        is_deeply(
            $env->{$key},
            $expect{$key},
            "inline_coercion_and_check merges all inline environment hashes together - $key",
        );
    }
}

done_testing();
