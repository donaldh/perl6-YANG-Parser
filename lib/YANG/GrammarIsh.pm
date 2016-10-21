use v6;

#use Grammar::Tracer;

grammar YANG::GrammarIsh {

    constant INDENT = '  ';

    class Node {
        has $.type;
        has $.value;

        method dump(@parts, Str $indent = '') {
            my $concatenated = $!value.join("+\n{$indent}{INDENT}");
            if $!type ~~ 'description' | 'contact' | 'organization' | 'reference' {
                @parts.push: "{$indent}{$!type}";
                @parts.push: "{$indent}{INDENT}{$concatenated};";
            } else {
                @parts.push: "{$indent}{$!type} {$concatenated};";
            }
        }
    }

    class Container is Node {
        has @.children;

        method dump(@parts, Str $indent = '') {
            @parts.push: "{$indent}{$.type}{' ' ~ $.value if $.value} \{";
            for @!children -> $c {
                $c.dump(@parts, $indent ~ INDENT);
            }
            @parts.push: "{$indent}\}";
        }
    }

    class Module is Container {
        method Str() {
            my @parts;
            self.dump(@parts);
            @parts.join: "\n";
        }
    }

    class Actions {
        method TOP($/) {
            make Module.new(
                type => ~$<module><keyword>,
                value => ~$<module><value>,
                children => $<module><contents>.map(*.made)
            );
        }

        method contents($/) {
            make $<item>.made;
        }

        method statement($/) {
            make Node.new(
                type => ~$<keyword>,
                value => $<value>.map(*.made)
            );
        }

        method definition($/) {
            my $val = ~$<value> if $<value>;
            make Container.new(
                type => ~$<keyword>,
                value => $val,
                children => $<contents>.map(*.made)
            );
        }

        method value($/) {
            make ~$<val>;
        }
    }

    method parse(|c) { nextwith(actions => Actions, |c); }
    method subparse(|c) { nextwith(actions => Actions, |c); }

    rule TOP {
        <module=.definition>
    }

    rule contents {
        <item=.definition> | <item=.statement>
    }

    rule definition {
        <keyword>  <value>? '{'
            <contents>*
        '}'
    }

    rule statement {
        <keyword> <value> [ '+' <value> ]* ';'
    }

    token keyword {
        <[ \w - ]> +
    }

    token value {
        <val=.word> | <val=.dquoted> | <val=.squoted>
    }

    token word {
        \w <[ \w \- _ : . ]>*
    }

    token dquoted {
        '"' <-[ " ]> + '"'
    }

    token squoted {
        "'" <-[ ' ]> + "'"
    }

    token ws {
       [ [ '/*' [ <-[ * ]> | '*' <!before '/'> ]+ '*/' ] | \s ]*
    }
}
