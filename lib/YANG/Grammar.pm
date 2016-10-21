use v6;

# use Grammar::Tracer;
use YANG::Grammar::Actions;

grammar YANG::Grammar {

    method parse(|c) { nextwith(actions => YANG::Grammar::Actions, |c); }
    method subparse(|c) { nextwith(actions => YANG::Grammar::Actions, |c); }

    rule TOP {
        <module> | <submodule>
    }

    rule module {
        'module' <value> '{'
        <header-stmts>
        <linkage-stmts>
        <meta-stmts>
        <revision-stmts>
        <body-stmts>
        '}'
    }

    rule submodule {
        'submodule' <value> '{'
        <submodule-header-stmts>
        <linkage-stmts>
        <meta-stmts>
        <revision-stmts>
        <body-stmts>
        '}'
    }

    rule header-stmts {
        <yang-version>?
        <namespace-stmt>
        <prefix-stmt>
    }

    rule submodule-header-stmts {
        <yang-version>?
        <belongs-to-stmt>
    }

    rule belongs-to-stmt {
        'belongs-to' <value> '{'
        <prefix-stmt>
        '}'
    }

    rule yang-version {
        'yang-version' <value> ';'
    }

    rule namespace-stmt {
        'namespace' <value> ';'
    }

    rule prefix-stmt {
        'prefix' <value> ';'
    }

    rule linkage-stmts {
        <import-stmt>*
    }

    rule import-stmt {
        'import' <module=.value> '{'
        'prefix' <prefix=.value> ';'
        <revision-stmt>?
        '}'
    }

    rule revision-stmts {
        <revision-stmt>*
    }

    rule revision-stmt {
        'revision' <value>
        [ ';' | '{' <description-stmt>? <reference-stmt>? '}' ]
    }

    rule description-stmt {
        'description' <value> ';'
    }

    rule reference-stmt {
        'reference' <value> ';'
    }

    rule meta-stmts {
        [ 'organization' <org=.value> ';' ]?
        [ 'contact' <contact=.value> ';' ]?
        <description-stmt>?
        <reference-stmt>?
    }

    rule body-stmts {
        [ <stmt=.extension-stmt> | <stmt=.feature-stmt> | <stmt=.identity-stmt> | <stmt=.typedef-stmt> | <stmt=.grouping-stmt>
          | <stmt=.data-def-stmt> | <stmt=.augment-stmt> | <stmt=.rpc-stmt> | <stmt=.notification-stmt> | <stmt=.deviation-stmt> ]*
    }

    rule feature-stmt {
        'feature' <value> ';'
    }

    rule identity-stmt {
        'identity' <value> ';'
    }

    rule typedef-stmt {
        'typedef' <value> '{'
        <type-stmt>
        <description-stmt>?
        '}'
    }

    rule type-stmt {
        'type' <value> [ ';' | '{' [
              <range-stmt> | <fraction-digits-stmt> | <string-restrictions> |
              <enum-stmt> | <path-stmt> | <base-stmt> |
              <require-instance-stmt> | <bits-specification> | <union-specification>
         ] '}' ]
    }

    rule range-stmt {
        'range' <value> [ ';' | '{' # TODO children
                          '}' ]
    }

    rule fraction-digits-stmt {
        'fraction-digits' <value> ';'
    }

    rule string-restrictions {
        <length-stmt>
        <pattern-stmt>*
    }

    rule length-stmt {
        'length' <length-arg> [ ';' | '{' # TODO children
                                '}' ]
    }

    rule length-arg {
        <length-part>*
    }

    rule length-part {
        <length-boundary>* # TODO
    }

    rule length-boundary {
        'min' | 'max' | \d+
    }

    rule enum-stmt {
        'enum' <value> [ ';' | '{' # TODO children
                         '}' ]
    }

    rule path-stmt {
        'path' <value> ';'
        <require-instance-stmt>?
    }

    rule require-instance-stmt {
        'require-instance' <truth-value> ';'
    }

    rule truth-value {
        'true' | 'false'
    }

    rule base-stmt {
        'base' <value> ';'
    }

    rule bits-specification {
        <bit-stmt>+
    }

    rule bit-stmt {
        'bit' <value> [ ';' | '{' # TODO children
                        '}' ]
    }

    rule union-specification {
        <type-stmt>+
    }

    rule grouping-stmt {
        'grouping' <value> '{'
        <contents>*
        '}'
    }

    rule data-def-stmt {
        <stmt=.container-stmt> | <stmt=.leaf-stmt> | <stmt=.leaf-list-stmt> | <stmt=.list-stmt>
        | <stmt=.choice-stmt> | <stmt=.anyxml-stmt> | <stmt=.uses-stmt>
    }

    rule container-stmt {
        'container' <value> '{'
        <data-def-stmt>*
        '}'
    }

    rule leaf-stmt {
        'leaf' <value> '{'
        <contents>*
        '}'
    }

    rule leaf-list-stmt {
        'leaf-list' <value> '{'
        <contents>*
        '}'
    }

    rule list-stmt {
        'list' <value> '{'
        <contents>*
        '}'
    }

    rule choice-stmt {
        'choice' <value> '{'
        <contents>*
        '}'
    }

    rule anyxml-stmt {
        'anyxml' <value> '{'
        <contents>*
        '}'
    }

    rule uses-stmt {
        'uses' <value>
        [ ';' ]
    }

    rule augment-stmt {
        'augment' <value> '{'
        <contents>*
        '}'
    }

    rule notification-stmt {
        'notification' <value> '{'
        <contents>*
        '}'
    }

    rule deviation-stmt {
        'deviation' <value> '{'
        <contents>*
        '}'
    }

    rule extension-stmt {
        'extension' <value>
        [ ';' | '{' <argument-stmt>? <status-stmt>? <description-stmt>? <reference-stmt>? '}' ]
    }

    rule argument-stmt {
        'argument' <value>
        [ ';' | '{' 'yin-element' <value> '}' ]
    }

    rule status-stmt {
        'status' [ 'current' | 'obsolete' | 'deprecated' ] ';'
    }

    rule rpc-stmt {
        'rpc' <value> '{'
        <statement>?
        <input>?
        <output>?
        '}'
    }

    rule input {
        'input' '{'
        <contents>*
        '}'
    }

    rule output {
        'output' '{'
        <contents>*
        '}'
    }

    rule definition {
        <keyword>  <value> '{'
            <contents>*
        '}'
    }

    rule contents {
        <statement> | <definition>
    }

    rule statement {
        <keyword> <value> [ '+' <value> ]* ';'
    }

    token keyword {
        <[ \w - ]> +
    }

    token value {
        <word> | <dquoted> | <squoted>
    }

    token word {
        \w <[ \w \- _ : . ]>*
    }

    token dquoted {
        ['"'] <-[ " ]> + '"'
    }

    token squoted {
        "'" <-[ ' ]> + "'"
    }

    token ws {
       [ [ '/*' [ <-[ * ]> | '*' <!before '/'> ]+ '*/' ] | \s ]*
    }
}
