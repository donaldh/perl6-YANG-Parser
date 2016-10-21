use v6;
use fatal;

use lib './lib';

use Test;
use YANG::GrammarIsh;

plan 5;

sub parse-file-ok(Str $file) {
    my $yang = slurp $file or die 'Failed to read ' ~ $file;
    my $parsed = YANG::GrammarIsh.parse($yang);
    isa-ok $parsed, Match, 'Parsed ' ~ $file;
}

sub parse-ok(Str $yang, Str $message = '', :$compare = True) {
    my $parsed = YANG::GrammarIsh.parse($yang);
    subtest $message, {
        isa-ok $parsed, Match;
        isa-ok $parsed.made, YANG::GrammarIsh::Module;
        is $parsed.made.Str ~ "\n", $yang, 'successful roundtrip' if $compare;
    }
}

parse-ok Q:to<EOF>, 'Mini module', :compare(False);
module bogus-module {
  /* commenty comment */
  namespace "urn:bogus:module";
  prefix bogus;
  import other-thing {
    prefix other;
  }

  organization "Welcome to the World of Fun";

  contact
    "Mary had a little lamb
     Its fleece was white as snow
     Everywhere that Mary went
     The lamb was sure to go.";
  description 'none';
  /*********
   * comment
   *********/
  revision 2016-10-04 {
    description "Latest revision";
  }

  typedef funky-type {
    type string;
  }

  container hello-theres {
    list hello-there {
      key 'name';
      uses bogus;
    }
  }

  grouping bogus {
    leaf name {
      type funky-type;
    }
  }
}
EOF

parse-ok Q:to<EOF>, 'Rpc input / output';
module m {
  rpc io-example {
    input {
    }
    output {
    }
  }
}
EOF

parse-ok Q:to<EOF>, 'Joined string';
module m {
  description
    "Hello there"+
    " split over lines";
  leaf source-tp {
    type leafref {
      path "../../../nd:node[nd:node-id=current()/../"+
        "source-node]/termination-point/tp-id";
      require-instance false;
    }
  }
}
EOF

parse-file-ok 't/ietf-network@2016-09-19.yang';
parse-file-ok 't/ietf-network-topology@2016-09-19.yang';
