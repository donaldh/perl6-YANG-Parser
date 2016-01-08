use v6;
use fatal;

use YANG::ABNF;
use Grammar::ABNF;

my $g = Grammar::ABNF.generate($yang-abnf);

constant YANG-Grammar is export = $g;
