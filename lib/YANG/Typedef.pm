use v6;

class YANG::Typedef {
    has $.name is required;
    has $.type is required;
    has $.descr;
}
