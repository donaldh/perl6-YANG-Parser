use v6;

class YANG::Import {
    has $.module is required;
    has $.prefix is required;

    method Str() {
        qq:to<END>
          import $!module
            prefix $!prefix
        END
    }
}
