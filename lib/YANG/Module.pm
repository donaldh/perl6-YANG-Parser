use v6;

class YANG::Module {
    has $.name is required;
    has $.namespace is required;
    has $.prefix is required;
    has $.version;
    has @.imports;
    has $.organization;
    has $.contact;
    has $.description;
    has $.reference;
    has @.revisions;
    has @.stmts;
}
