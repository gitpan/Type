
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  "build_requires" => {
    "IO::File" => 0,
    "Module::Build" => "0.3601",
    "Test::Fatal" => 0,
    "Test::More" => "0.88",
    "encoding" => 0
  },
  "c_source" => "c",
  "configure_requires" => {
    "Module::Build" => "0.3601"
  },
  "dist_abstract" => "Type constraints and coercions for Perl",
  "dist_author" => [
    "Dave Rolsky <autarch\@urth.org>"
  ],
  "dist_name" => "Type",
  "dist_version" => "0.04",
  "license" => "artistic_2",
  "module_name" => "Type",
  "recommends" => {},
  "recursive_test_files" => 1,
  "requires" => {
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
    "perl" => "v5.10.0",
    "strict" => 0,
    "warnings" => 0
  },
  "script_files" => []
);


my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
