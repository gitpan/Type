
use strict;
use warnings;

use 5.010000;

use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Type constraints and coercions for Perl",
  "AUTHOR" => "Dave Rolsky <autarch\@urth.org>",
  "BUILD_REQUIRES" => {
    "IO::File" => 0,
    "Test::Fatal" => 0,
    "Test::More" => "0.88",
    "encoding" => 0
  },
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "Type",
  "EXE_FILES" => [],
  "LICENSE" => "artistic_2",
  "NAME" => "Type",
  "PREREQ_PM" => {
    "B" => 0,
    "Carp" => 0,
    "Class::Load" => 0,
    "Devel::PartialDump" => 0,
    "Eval::Closure" => 0,
    "Exporter" => 0,
    "Lingua::EN::Inflect" => 0,
    "List::AllUtils" => 0,
    "List::MoreUtils" => 0,
    "Moose" => 0,
    "Moose::Role" => 0,
    "MooseX::Clone" => 0,
    "MooseX::Params::Validate" => 0,
    "MooseX::SemiAffordanceAccessor" => 0,
    "Params::Util" => 0,
    "Scalar::Util" => 0,
    "Sub::Name" => 0,
    "Throwable::Error" => 0,
    "Try::Tiny" => 0,
    "namespace::autoclean" => 0,
    "overload" => 0,
    "parent" => 0,
    "re" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "VERSION" => "0.05",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



