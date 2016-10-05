use v6;

#use Grammar::Tracer;

grammar YANG::GrammarIsh {

    constant INDENT = '  ';

    class Node {
        has $.type;
        has $.value;
        has @.children;

        method dump(@parts, Str $indent = '') {
            if @!children {
                @parts.push: "{$indent}{$!type} {$!value if $!value} \{";
                for @!children -> $c {
                    $c.dump(@parts, $indent ~ INDENT);
                }
                @parts.push: "{$indent}\}";
            } else {
                if $!type ~~ 'description' | 'contact' | 'organization' | 'reference' {
                    @parts.push: "{$indent}{$!type}";
                    @parts.push: "{$indent}{INDENT}{$!value};";
                } else {
                    my $concatenated = $!value.join("+\n{$indent}{INDENT}");
                    @parts.push: "{$indent}{$!type} {$concatenated};";
                }
            }
        }
    }

    class Module is Node {

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
            make Node.new(
                type => ~$<keyword>,
                value => ~$<value>,
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
        <item=.statement> | <item=.definition>
    }

    rule statement {
        <keyword> <value> [ '+' <value> ]* ';'
    }

    rule definition {
        <keyword>  <value>? '{'
            <contents>*
        '}'
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
