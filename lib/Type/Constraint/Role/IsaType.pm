package Type::Constraint::Role::IsaType;
{
  $Type::Constraint::Role::IsaType::VERSION = '0.02'; # TRIAL
}

use strict;
use warnings;

use Moose::Role;

with 'Type::Constraint::Role::Interface';

has class => (
    is       => 'ro',
    isa      => 'ClassName',
    required => 1,
);

my $_default_message_generator = sub {
    my $self  = shift;
    my $thing = shift;
    my $value = shift;

    return
          q{Validation failed for } 
        . $thing
        . q{ with value }
        . Devel::PartialDump->new()->dump($value)
        . '(not isa '
        . $self->class() . ')';
};

sub _default_message_generator { return $_default_message_generator }

1;

# ABSTRACT: Provides a common implementation for Type::Constraint::AnyIsa and Type::Constraint::ObjectIsa



=pod

=head1 NAME

Type::Constraint::Role::IsaType - Provides a common implementation for Type::Constraint::AnyIsa and Type::Constraint::ObjectIsa

=head1 VERSION

version 0.02

=head1 DESCRIPTION

See L<Type::Constraint::AnyIsa> and L<Type::Constraint::ObjectIsa> for details.

=head1 AUTHOR

Dave Rolsky <autarch@urth.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2012 by Dave Rolsky.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut


__END__

