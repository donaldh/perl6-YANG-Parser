use v6;

class YANG::Container {
    has $.name is required;
    has @.children;
    has $.descr;

    method Str() {
        qq:to<END>
            container $!name \{
            description
            $!descr ;
            \}
        END
    }
}
