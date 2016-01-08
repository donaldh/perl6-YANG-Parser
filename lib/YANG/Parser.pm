use v6;
use fatal;

use YANG::ABNF;
use Grammar::ABNF;

our $yang-parser is export = Grammar::ABNF.generate($yang-abnf, :name<YANG-Parser>);
