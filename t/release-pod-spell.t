
BEGIN {
  unless ($ENV{RELEASE_TESTING}) {
    require Test::More;
    Test::More::plan(skip_all => 'these tests are for release candidate testing');
  }
}

use strict;
use warnings;

use Test::Spelling;

my @stopwords;
for (<DATA>) {
    chomp;
    push @stopwords, $_
        unless /\A (?: \# | \s* \z)/msx;    # skip comments, whitespace
}

add_stopwords(@stopwords);
set_spell_cmd('aspell list -l en');

# This prevents a weird segfault from the aspell command - see
# https://bugs.launchpad.net/ubuntu/+source/aspell/+bug/71322
local $ENV{LC_ALL} = 'C';
all_pod_files_spelling_ok;

__DATA__
API
ClassName
MUTC
PARAMETERIZABLE
PayPal
Rolsky
ScalarRef
Throwable
boolification
distro
globification
inlinable
inline
isa
parameterizable
parameterization
parameterized
sigils
