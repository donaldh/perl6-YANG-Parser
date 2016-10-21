use v6;

use YANG::Module;
use YANG::Import;
use YANG::Typedef;
use YANG::Container;
use YANG::Revision;

class YANG::Grammar::Actions {

    method TOP($/) {
        say $<module>.made;
        make $<module>.made // $<submodule>.made;
    }

    method module($/) {
        make YANG::Module.new(
            name => $<value>.made,
            | $<header-stmts>.made,
            | $<meta-stmts>.made,
            | $<linkage-stmts>.made,
            | $<revision-stmts>.made,
            | $<body-stmts>.made
        );
    }

    method header-stmts($/) {
        make %(
            namespace => $<namespace-stmt>.made,
            prefix => $<prefix-stmt>.made,
            version => $<yang-version>.made // Nil
        )
    }

    method namespace-stmt($/) {
        make $<value>.made
    }

    method prefix-stmt($/) {
        make $<value>.made
    }

    method yang-version($/) {
        make $<value>.made
    }

    method linkage-stmts($/) {
        make %(
            imports => $<import-stmt>.map(*.made).eager
        )
    }

    method import-stmt($/) {
        make YANG::Import.new(
            module => ~$<module>,
            prefix => ~$<prefix>
        );
    }

    method revision-stmts($/) {
        make %(
            revisions => $<revision-stmt>.map(*.made).eager
        )
    }

    method revision-stmt($/) {
        make YANG::Revision.new(
            revision => $<value>.made,
            description => $<description-stmt>.made // Nil,
            reference => $<reference-stmt>.made // Nil
        )
    }

    method meta-stmts($/) {
        make %(
            contact => $<contact>.made // Nil,
            organization => $<org>.made // Nil,
            description => $<description-stmt>.made // Nil,
            reference => $<reference-stmt>.made // Nil
        )
    }

    method description-stmt($/) {
        make $<value>.made
    }

    method reference-stmt($/) {
        make $<value>.made
    }

    method body-stmts($/) {
        make %(
            stmts => $<stmt>.map(*.made).eager
        )
    }

    method typedef-stmt($/) {
        make YANG::Typedef.new(
            name => $<value>.made,
            type => $<type-stmt>.made
        );
    }

    method type-stmt($/) {
        make $<value>.made
    }

    method data-def-stmt($/) {
        make $<stmt>.made
    }

    method container-stmt($/) {
        make YANG::Container.new(
            name => ~$<value>
        );
    }

    method value($/) {
        make ~$/;
    }
}
