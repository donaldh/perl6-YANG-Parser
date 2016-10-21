use v6;
use fatal;

use lib './lib';

use Test;
use YANG::Grammar;

plan 5;

sub parse-file-ok(Str $file) {
    my $yang = slurp $file or die 'Failed to read ' ~ $file;
    my $parsed = YANG::Grammar.parse($yang);
    isa-ok $parsed, Match, 'Parsed ' ~ $file;
}

sub parse-ok(Str $yang, Str $message = '', :$compare = True) {
    my $parsed = YANG::Grammar.parse($yang);
    subtest $message, {
        isa-ok $parsed, Match;
        isa-ok $parsed.made, YANG::Module;
        is $parsed.made.Str ~ "\n", $yang, 'successful roundtrip' if $compare;
    }
}

parse-ok Q:to<EOF>, 'Simple module definition', :compare(False);
module my-module {
    namespace "urn:my:module";
    prefix mym;
}
EOF

parse-ok Q:to<EOF>, 'Yang version', :compare(False);
module my-module {
    yang-version 1;
    namespace "urn:my:module";
    prefix mym;
}
EOF

parse-ok Q:to<EOF>, 'Revisions', :compare(False);
module my-module {
    namespace "urn:my:module";
    prefix mym;

    revision 2016-10-21 {
    }

    revision 2016-10-01;

    revision 2016-01-01 {
        description "First revision";
    }
}
EOF

parse-ok Q:to<EOF>, 'Module imports', :compare(False);
module my-module {
    namespace "urn:my:module";
    prefix mym;

    import another-module {
        prefix am;
    }

    import yet-another {
        prefix ya;
    }
}
EOF

parse-ok Q:to<EOF>, 'Meta headers', :compare(False);
module my-module {
    namespace "urn:my:module";
    prefix mym;
    organization "Cisco Systems Inc";
    contact "Donald Hunter";
    description "Well, hello there";
    reference "This is a bogus reference";
}
EOF

parse-ok Q:to<EOF>, 'Typedef stmts', :compare(False);
module my-module {
    namespace "urn:my:module";
    prefix mym;

    typedef stringy-thing {
        type string;
    }

    typedef inty-thing {
        type int;
    }

    typedef leafy-thing {
        type leafref {
            path '/mym:home';
        }
    }
}
EOF

parse-ok Q:to<EOF>, 'Container stmts', :compare(False);
module my-module {
    namespace "urn:my:module";
    prefix mym;

    container outer {
        container inner {
        }
    }
}
EOF

