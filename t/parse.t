use v6;
use lib './lib';

use Test;

use YANG::Parser;

my $yang = slurp 't/mef-sca-app-config.yang' or die 'Failed to read yang file';
