package Type::Constraint::Simple;
{
  $Type::Constraint::Simple::VERSION = '0.01'; # TRIAL
}

use strict;
use warnings;
use namespace::autoclean;

use Moose;

with 'Type::Constraint::Role::Interface';

__PACKAGE__->meta()->make_immutable();

1;

# ABSTRACT: Class for simple (non-parameterized or specialized) types



=pod

=head1 NAME

Type::Constraint::Simple - Class for simple (non-parameterized or specialized) types

=head1 VERSION

version 0.01

=head1 AUTHOR

Dave Rolsky <autarch@urth.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2012 by Dave Rolsky.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut


__END__
