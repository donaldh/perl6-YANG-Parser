use v6;

class YANG::Module {
    has $.name is required;
    has $.namespace is required;
    has $.prefix is required;
    has @.imports;
    has $.organization;
    has $.contact;
    has $.description;
    has @.revisions;
    has @.stmts;

    method Str() {
        qq:to<END>
        module $!name
          namespace $!namespace
          prefix $!prefix
          organization $!organization
          contact $!contact
          description $!description
          imports
          {~@!imports}
        END
    }
}
