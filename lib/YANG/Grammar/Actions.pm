use v6;

use YANG::Module;
use YANG::Import;
use YANG::Typedef;
use YANG::Container;

class YANG::Grammar::Actions {

    method TOP($/) {
        make $<module>.made // $<submodule>.made;
    }

    method module($/) {
        make YANG::Module.new(
            name => ~$<value>,
            namespace => ~$<header-stmts><namespace-stmt><value>,
            prefix => ~$<header-stmts><prefix-stmt><value>,
            imports => $<linkage-stmts><import-stmt>.map(*.made),
            organization => ~$<meta-stmts><org>,
            contact => ~$<meta-stmts><contact>,
            description => ~$<meta-stmts><description-stmt><value>,
            stmts => $<body-stmts><stmt>.map(*.made)
        );
    }

    method import-stmt($/) {
        make YANG::Import.new(
            module => ~$<module>,
            prefix => ~$<prefix>
        );
    }

    method typedef-stmt($/) {
        make YANG::Typedef.new(
            name => ~$<value>,
            type => ~$<type-stmt><value>
        );
    }

    method data-def-stmt($/) {
        make $<stmt>.made
    }

    method container-stmt($/) {
        make YANG::Container.new(
            name => ~$<value>
        );
    }
}
