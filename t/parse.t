use v6;
use fatal;

use lib './lib';

use Test;

use YANG::Parser;

plan 1;

my $yang = slurp 't/mef-sca-app-config.yang' or die 'Failed to read yang file';
my $res = $yang-parser.parse($yang);
isa-ok $res, Match;

