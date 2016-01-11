use v6;
unit package YANG::ABNF;

constant $yang-abnf is export = Q:to<END>;
module-stmt = optsep module-keyword sep identifier-arg-str optsep "{" stmtsep module-header-stmts linkage-stmts meta-stmts revision-stmts body-stmts "}" optsep

submodule-stmt = optsep submodule-keyword sep identifier-arg-str optsep "{" stmtsep submodule-header-stmts linkage-stmts meta-stmts revision-stmts body-stmts "}" optsep

module-header-stmts = [yang-version-stmt stmtsep] namespace-stmt stmtsep prefix-stmt stmtsep

submodule-header-stmts = [yang-version-stmt stmtsep] belongs-to-stmt stmtsep

meta-stmts = [organization-stmt stmtsep] [contact-stmt stmtsep] [description-stmt stmtsep] [reference-stmt stmtsep]

linkage-stmts = *(import-stmt stmtsep) *(include-stmt stmtsep)

revision-stmts = *(revision-stmt stmtsep)

body-stmts = *((extension-stmt / feature-stmt / identity-stmt / typedef-stmt / grouping-stmt / data-def-stmt / augment-stmt / rpc-stmt / notification-stmt / deviation-stmt) stmtsep)

data-def-stmt = container-stmt / leaf-stmt / leaf-list-stmt / list-stmt / choice-stmt / anyxml-stmt / uses-stmt

yang-version-stmt = yang-version-keyword sep yang-version-arg-str optsep stmtend

yang-version-arg-str = yang-version-arg ; < a string that matches the rule yang-version-arg >

yang-version-arg = "1"

import-stmt = import-keyword sep identifier-arg-str optsep "{" stmtsep prefix-stmt stmtsep [revision-date-stmt stmtsep] "}"

include-stmt = include-keyword sep identifier-arg-str optsep (";" / "{" stmtsep [revision-date-stmt stmtsep] "}")

namespace-stmt = namespace-keyword sep uri-str optsep stmtend

uri-str = DQUOTE URI DQUOTE; < a string that matches the rule URI in RFC 3986 >

prefix-stmt = prefix-keyword sep prefix-arg-str optsep stmtend

belongs-to-stmt = belongs-to-keyword sep identifier-arg-str optsep "{" stmtsep prefix-stmt stmtsep "}"

organization-stmt = organization-keyword sep string optsep stmtend

contact-stmt = contact-keyword sep string optsep stmtend

description-stmt = description-keyword sep string optsep stmtend

reference-stmt = reference-keyword sep string optsep stmtend

units-stmt = units-keyword sep string optsep stmtend

revision-stmt = revision-keyword sep revision-date optsep (";" / "{" stmtsep [description-stmt stmtsep] [reference-stmt stmtsep] "}")

revision-date = date-arg-str

revision-date-stmt = revision-date-keyword sep revision-date stmtend

extension-stmt = extension-keyword sep identifier-arg-str optsep (";" / "{" stmtsep [argument-stmt stmtsep] [status-stmt stmtsep] [description-stmt stmtsep] [reference-stmt stmtsep] "}")

argument-stmt = argument-keyword sep identifier-arg-str optsep (";" / "{" stmtsep [yin-element-stmt stmtsep] "}")

yin-element-stmt = yin-element-keyword sep yin-element-arg-str stmtend

yin-element-arg-str = < a string that matches the rule yin-element-arg >

yin-element-arg = true-keyword / false-keyword

identity-stmt = identity-keyword sep identifier-arg-str optsep (";" / "{" stmtsep [base-stmt stmtsep] [status-stmt stmtsep] [description-stmt stmtsep] [reference-stmt stmtsep] "}")

base-stmt = base-keyword sep identifier-ref-arg-str optsep stmtend

feature-stmt = feature-keyword sep identifier-arg-str optsep (";" / "{" stmtsep *(if-feature-stmt stmtsep) [status-stmt stmtsep] [description-stmt stmtsep] [reference-stmt stmtsep] "}")

if-feature-stmt = if-feature-keyword sep identifier-ref-arg-str optsep stmtend

typedef-stmt = typedef-keyword sep identifier-arg-str optsep "{" stmtsep type-stmt stmtsep [units-stmt stmtsep] [default-stmt stmtsep] [status-stmt stmtsep] [description-stmt stmtsep] [reference-stmt stmtsep] "}"

type-stmt = type-keyword sep identifier-ref-arg-str optsep (";" / "{" stmtsep type-body-stmts "}")

type-body-stmts = numerical-restrictions / decimal64-specification / string-restrictions / enum-specification / leafref-specification / identityref-specification / instance-identifier-specification / bits-specification / union-specification

numerical-restrictions = range-stmt stmtsep

range-stmt = range-keyword sep range-arg-str optsep (";" / "{" stmtsep [error-message-stmt stmtsep] [error-app-tag-stmt stmtsep] [description-stmt stmtsep] [reference-stmt stmtsep] "}")

decimal64-specification = fraction-digits-stmt

fraction-digits-stmt = fraction-digits-keyword sep fraction-digits-arg-str stmtend

fraction-digits-arg-str = < a string that matches the rule fraction-digits-arg >

fraction-digits-arg = ("1" ["0" / "1" / "2" / "3" / "4" / "5" / "6" / "7" / "8"]) / "2" / "3" / "4" / "5" / "6" / "7" / "8" / "9"

string-restrictions = [length-stmt stmtsep] *(pattern-stmt stmtsep)

length-stmt = length-keyword sep length-arg-str optsep (";" / "{" stmtsep [error-message-stmt stmtsep] [error-app-tag-stmt stmtsep] [description-stmt stmtsep] [reference-stmt stmtsep] "}")

pattern-stmt = pattern-keyword sep string optsep (";" / "{" stmtsep [error-message-stmt stmtsep] [error-app-tag-stmt stmtsep] [description-stmt stmtsep] [reference-stmt stmtsep] "}")

default-stmt = default-keyword sep string stmtend

enum-specification = 1*(enum-stmt stmtsep)

enum-stmt = enum-keyword sep string optsep (";" / "{" stmtsep [value-stmt stmtsep] [status-stmt stmtsep] [description-stmt stmtsep] [reference-stmt stmtsep] "}")

leafref-specification = path-stmt stmtsep [require-instance-stmt stmtsep]

path-stmt = path-keyword sep path-arg-str stmtend

require-instance-stmt = require-instance-keyword sep require-instance-arg-str stmtend

require-instance-arg-str = < a string that matches the rule require-instance-arg >

require-instance-arg = true-keyword / false-keyword

instance-identifier-specification = [require-instance-stmt stmtsep]

identityref-specification = base-stmt stmtsep

union-specification = 1*(type-stmt stmtsep)

bits-specification = 1*(bit-stmt stmtsep)

bit-stmt = bit-keyword sep identifier-arg-str optsep (";" / "{" stmtsep [position-stmt stmtsep] [status-stmt stmtsep] [description-stmt stmtsep] [reference-stmt stmtsep] "}" "}")

position-stmt = position-keyword sep position-value-arg-str stmtend

position-value-arg-str = < a string that matches the rule position-value-arg >

position-value-arg = non-negative-integer-value

status-stmt = status-keyword sep status-arg-str stmtend

status-arg-str = < a string that matches the rule status-arg >

status-arg = current-keyword / obsolete-keyword / deprecated-keyword

config-stmt = config-keyword sep config-arg-str stmtend

config-arg-str = < a string that matches the rule config-arg >

config-arg = true-keyword / false-keyword

mandatory-stmt = mandatory-keyword sep mandatory-arg-str stmtend

mandatory-arg-str = < a string that matches the rule mandatory-arg >

mandatory-arg = true-keyword / false-keyword

presence-stmt = presence-keyword sep string stmtend

ordered-by-stmt = ordered-by-keyword sep ordered-by-arg-str stmtend

ordered-by-arg-str = < a string that matches the rule ordered-by-arg >

ordered-by-arg = user-keyword / system-keyword

must-stmt = must-keyword sep string optsep (";" / "{" stmtsep [error-message-stmt stmtsep] [error-app-tag-stmt stmtsep] [description-stmt stmtsep] [reference-stmt stmtsep] "}")

error-message-stmt = error-message-keyword sep string stmtend

error-app-tag-stmt = error-app-tag-keyword sep string stmtend

min-elements-stmt = min-elements-keyword sep min-value-arg-str stmtend

min-value-arg-str = < a string that matches the rule min-value-arg >

min-value-arg = non-negative-integer-value

max-elements-stmt = max-elements-keyword sep max-value-arg-str stmtend

max-value-arg-str = < a string that matches the rule max-value-arg >

max-value-arg = unbounded-keyword / positive-integer-value

value-stmt = value-keyword sep integer-value stmtend

grouping-stmt = grouping-keyword sep identifier-arg-str optsep (";" / "{" stmtsep [status-stmt stmtsep] [description-stmt stmtsep] [reference-stmt stmtsep] *((typedef-stmt / grouping-stmt) stmtsep) *(data-def-stmt stmtsep) "}")

container-stmt = container-keyword sep identifier-arg-str optsep (";" / "{" stmtsep [when-stmt stmtsep] *(if-feature-stmt stmtsep) *(must-stmt stmtsep) [presence-stmt stmtsep] [config-stmt stmtsep] [status-stmt stmtsep] [description-stmt stmtsep] [reference-stmt stmtsep] *((typedef-stmt / grouping-stmt) stmtsep) *(data-def-stmt stmtsep) "}")

leaf-stmt = leaf-keyword sep identifier-arg-str optsep "{" stmtsep [when-stmt stmtsep] *(if-feature-stmt stmtsep) type-stmt stmtsep [units-stmt stmtsep] *(must-stmt stmtsep) [default-stmt stmtsep] [config-stmt stmtsep] [mandatory-stmt stmtsep] [status-stmt stmtsep] [description-stmt stmtsep] [reference-stmt stmtsep] "}"

leaf-list-stmt = leaf-list-keyword sep identifier-arg-str optsep "{" stmtsep [when-stmt stmtsep] *(if-feature-stmt stmtsep) type-stmt stmtsep [units-stmt stmtsep] *(must-stmt stmtsep) [config-stmt stmtsep] [min-elements-stmt stmtsep] [max-elements-stmt stmtsep] [ordered-by-stmt stmtsep] [status-stmt stmtsep] [description-stmt stmtsep] [reference-stmt stmtsep] "}"

list-stmt = list-keyword sep identifier-arg-str optsep "{" stmtsep [when-stmt stmtsep] *(if-feature-stmt stmtsep) *(must-stmt stmtsep) [key-stmt stmtsep] *(unique-stmt stmtsep) [config-stmt stmtsep] [min-elements-stmt stmtsep] [max-elements-stmt stmtsep] [ordered-by-stmt stmtsep] [status-stmt stmtsep] [description-stmt stmtsep] [reference-stmt stmtsep] *((typedef-stmt / grouping-stmt) stmtsep) 1*(data-def-stmt stmtsep) "}"

key-stmt = key-keyword sep key-arg-str stmtend

key-arg-str = key-arg ; < a string that matches the rule key-arg >

key-arg = node-identifier *(sep node-identifier)

unique-stmt = unique-keyword sep unique-arg-str stmtend

unique-arg-str = < a string that matches the rule unique-arg >

unique-arg = descendant-schema-nodeid *(sep descendant-schema-nodeid)

choice-stmt = choice-keyword sep identifier-arg-str optsep (";" / "{" stmtsep [when-stmt stmtsep] *(if-feature-stmt stmtsep) [default-stmt stmtsep] [config-stmt stmtsep] [mandatory-stmt stmtsep] [status-stmt stmtsep] [description-stmt stmtsep] [reference-stmt stmtsep] *((short-case-stmt / case-stmt) stmtsep) "}")

short-case-stmt = container-stmt / leaf-stmt / leaf-list-stmt / list-stmt / anyxml-stmt

case-stmt = case-keyword sep identifier-arg-str optsep (";" / "{" stmtsep [when-stmt stmtsep] *(if-feature-stmt stmtsep) [status-stmt stmtsep] [description-stmt stmtsep] [reference-stmt stmtsep] *(data-def-stmt stmtsep) "}")

anyxml-stmt = anyxml-keyword sep identifier-arg-str optsep (";" / "{" stmtsep [when-stmt stmtsep] *(if-feature-stmt stmtsep) *(must-stmt stmtsep) [config-stmt stmtsep] [mandatory-stmt stmtsep] [status-stmt stmtsep] [description-stmt stmtsep] [reference-stmt stmtsep] "}")

uses-stmt = uses-keyword sep identifier-ref-arg-str optsep (";" / "{" stmtsep [when-stmt stmtsep] *(if-feature-stmt stmtsep) [status-stmt stmtsep] [description-stmt stmtsep] [reference-stmt stmtsep] *(refine-stmt stmtsep) *(uses-augment-stmt stmtsep) "}")

refine-stmt = refine-keyword sep refine-arg-str optsep (";" / "{" stmtsep (refine-container-stmts / refine-leaf-stmts / refine-leaf-list-stmts / refine-list-stmts / refine-choice-stmts / refine-case-stmts / refine-anyxml-stmts) "}")

refine-arg-str = < a string that matches the rule refine-arg >

refine-arg = descendant-schema-nodeid

refine-container-stmts = *(must-stmt stmtsep) [presence-stmt stmtsep] [config-stmt stmtsep] [description-stmt stmtsep] [reference-stmt stmtsep]

refine-leaf-stmts = *(must-stmt stmtsep) [default-stmt stmtsep] [config-stmt stmtsep] [mandatory-stmt stmtsep] [description-stmt stmtsep] [reference-stmt stmtsep]

refine-leaf-list-stmts = *(must-stmt stmtsep) [config-stmt stmtsep] [min-elements-stmt stmtsep] [max-elements-stmt stmtsep] [description-stmt stmtsep] [reference-stmt stmtsep]

refine-list-stmts = *(must-stmt stmtsep) [config-stmt stmtsep] [min-elements-stmt stmtsep] [max-elements-stmt stmtsep] [description-stmt stmtsep] [reference-stmt stmtsep]

refine-choice-stmts = [default-stmt stmtsep] [config-stmt stmtsep] [mandatory-stmt stmtsep] [description-stmt stmtsep] [reference-stmt stmtsep]

refine-case-stmts = [description-stmt stmtsep] [reference-stmt stmtsep]

refine-anyxml-stmts = *(must-stmt stmtsep) [config-stmt stmtsep] [mandatory-stmt stmtsep] [description-stmt stmtsep] [reference-stmt stmtsep]

uses-augment-stmt = augment-keyword sep uses-augment-arg-str optsep "{" stmtsep [when-stmt stmtsep] *(if-feature-stmt stmtsep) [status-stmt stmtsep] [description-stmt stmtsep] [reference-stmt stmtsep] 1*((data-def-stmt stmtsep) / (case-stmt stmtsep)) "}"

uses-augment-arg-str = < a string that matches the rule uses-augment-arg >

uses-augment-arg = descendant-schema-nodeid

augment-stmt = augment-keyword sep augment-arg-str optsep "{" stmtsep [when-stmt stmtsep] *(if-feature-stmt stmtsep) [status-stmt stmtsep] [description-stmt stmtsep] [reference-stmt stmtsep] 1*((data-def-stmt stmtsep) / (case-stmt stmtsep)) "}"

augment-arg-str = < a string that matches the rule augment-arg >

augment-arg = absolute-schema-nodeid

unknown-statement = prefix ":" identifier [sep string] optsep (";" / "{" *unknown-statement2 "}")

unknown-statement2 = [prefix ":"] identifier [sep string] optsep (";" / "{" *unknown-statement2 "}")

when-stmt = when-keyword sep string optsep (";" / "{" stmtsep [description-stmt stmtsep] [reference-stmt stmtsep] "}")

rpc-stmt = rpc-keyword sep identifier-arg-str optsep (";" / "{" stmtsep *(if-feature-stmt stmtsep) [status-stmt stmtsep] [description-stmt stmtsep] [reference-stmt stmtsep] *((typedef-stmt / grouping-stmt) stmtsep) [input-stmt stmtsep] [output-stmt stmtsep] "}")

input-stmt = input-keyword optsep "{" stmtsep *((typedef-stmt / grouping-stmt) stmtsep) 1*(data-def-stmt stmtsep) "}"

output-stmt = output-keyword optsep "{" stmtsep *((typedef-stmt / grouping-stmt) stmtsep) 1*(data-def-stmt stmtsep) "}"

notification-stmt = notification-keyword sep identifier-arg-str optsep (";" / "{" stmtsep *(if-feature-stmt stmtsep) [status-stmt stmtsep] [description-stmt stmtsep] [reference-stmt stmtsep] *((typedef-stmt / grouping-stmt) stmtsep) *(data-def-stmt stmtsep) "}")

deviation-stmt = deviation-keyword sep deviation-arg-str optsep "{" stmtsep [description-stmt stmtsep] [reference-stmt stmtsep] (deviate-not-supported-stmt / 1*(deviate-add-stmt / deviate-replace-stmt / deviate-delete-stmt)) "}"

deviation-arg-str = < a string that matches the rule deviation-arg >

deviation-arg = absolute-schema-nodeid

deviate-not-supported-stmt = deviate-keyword sep not-supported-keyword optsep (";" / "{" stmtsep "}")

deviate-add-stmt = deviate-keyword sep add-keyword optsep (";" / "{" stmtsep [units-stmt stmtsep] *(must-stmt stmtsep) *(unique-stmt stmtsep) [default-stmt stmtsep] [config-stmt stmtsep] [mandatory-stmt stmtsep] [min-elements-stmt stmtsep] [max-elements-stmt stmtsep] "}")

deviate-delete-stmt = deviate-keyword sep delete-keyword optsep (";" / "{" stmtsep [units-stmt stmtsep] *(must-stmt stmtsep) *(unique-stmt stmtsep) [default-stmt stmtsep] "}")

deviate-replace-stmt = deviate-keyword sep replace-keyword optsep (";" / "{" stmtsep [type-stmt stmtsep] [units-stmt stmtsep] [default-stmt stmtsep] [config-stmt stmtsep] [mandatory-stmt stmtsep] [min-elements-stmt stmtsep] [max-elements-stmt stmtsep] "}")

range-arg-str = range-arg ; < a string that matches the rule range-arg >

range-arg = range-part *(optsep "|" optsep range-part)

range-part = range-boundary [optsep ".." optsep range-boundary]

range-boundary = min-keyword / max-keyword / integer-value / decimal-value

length-arg-str = length-arg ; < a string that matches the rule length-arg >

length-arg = length-part *(optsep "|" optsep length-part)

length-part = length-boundary [optsep ".." optsep length-boundary]

length-boundary = min-keyword / max-keyword / non-negative-integer-value

date-arg-str = date-arg ; < a string that matches the rule date-arg >

date-arg = 4DIGIT "-" 2DIGIT "-" 2DIGIT

schema-nodeid = absolute-schema-nodeid / descendant-schema-nodeid

absolute-schema-nodeid = 1*("/" node-identifier)

descendant-schema-nodeid = node-identifier absolute-schema-nodeid

node-identifier = [prefix ":"] identifier

instance-identifier = 1*("/" (node-identifier *predicate))

predicate = "[" *WSP (predicate-expr / pos) *WSP "]"

predicate-expr = (node-identifier / ".") *WSP "=" *WSP ((DQUOTE string DQUOTE) / (SQUOTE string SQUOTE))

pos = non-negative-integer-value

path-arg-str = path-arg ; < a string that matches the rule path-arg >

path-arg = absolute-path / relative-path

absolute-path = 1*("/" (node-identifier *path-predicate))

relative-path = 1*(".." "/") descendant-path

descendant-path = node-identifier [*path-predicate absolute-path]

path-predicate = "[" *WSP path-equality-expr *WSP "]"

path-equality-expr = node-identifier *WSP "=" *WSP path-key-expr

path-key-expr = current-function-invocation *WSP "/" *WSP rel-path-keyexpr

rel-path-keyexpr = 1*(".." *WSP "/" *WSP) *(node-identifier *WSP "/" *WSP) node-identifier

anyxml-keyword = "anyxml"

argument-keyword = "argument"
augment-keyword = "augment"
base-keyword = "base"
belongs-to-keyword = "belongs-to"
bit-keyword = "bit"
case-keyword = "case"
choice-keyword = "choice"
config-keyword = "config"
contact-keyword = "contact"
container-keyword = "container"
default-keyword = "default"
description-keyword = "description"
enum-keyword = "enum"
error-app-tag-keyword = "error-app-tag"
error-message-keyword = "error-message"
extension-keyword = "extension"
deviation-keyword = "deviation"
deviate-keyword = "deviate"
feature-keyword = "feature"
fraction-digits-keyword = "fraction-digits"
grouping-keyword = "grouping"
identity-keyword = "identity"
if-feature-keyword = "if-feature"
import-keyword = "import"
include-keyword = "include"
input-keyword = "input"
key-keyword = "key"
leaf-keyword = "leaf"
leaf-list-keyword = "leaf-list"
length-keyword = "length"
list-keyword = "list"
mandatory-keyword = "mandatory"
max-elements-keyword = "max-elements"
min-elements-keyword = "min-elements"
module-keyword = "module"
must-keyword = "must"
namespace-keyword = "namespace"
notification-keyword= "notification"
ordered-by-keyword = "ordered-by"
organization-keyword= "organization"
output-keyword = "output"
path-keyword = "path"
pattern-keyword = "pattern"
position-keyword = "position"
prefix-keyword = "prefix"
presence-keyword = "presence"
range-keyword = "range"
reference-keyword = "reference"
refine-keyword = "refine"
require-instance-keyword = "require-instance"
revision-keyword = "revision"
revision-date-keyword = "revision-date"
rpc-keyword = "rpc"
status-keyword = "status"
submodule-keyword = "submodule"
type-keyword = "type"
typedef-keyword = "typedef"
unique-keyword = "unique"
units-keyword = "units"
uses-keyword = "uses"
value-keyword = "value"
when-keyword = "when"
yang-version-keyword= "yang-version"
yin-element-keyword = "yin-element"
add-keyword = "add"
current-keyword = "current"
delete-keyword = "delete"
deprecated-keyword = "deprecated"
false-keyword = "false"
max-keyword = "max"
min-keyword = "min"
not-supported-keyword = "not-supported"
obsolete-keyword = "obsolete"
replace-keyword = "replace"
system-keyword = "system"
true-keyword = "true"
unbounded-keyword = "unbounded"
user-keyword = "user"

current-function-invocation = current-keyword *WSP "(" *WSP ")"

prefix-arg-str = prefix-arg ; < a string that matches the rule prefix-arg >

prefix-arg = prefix

prefix = identifier

identifier-arg-str = identifier ; < a string that matches the rule identifier-arg >

identifier-arg = identifier

identifier = (ALPHA / "_") *(ALPHA / DIGIT / "_" / "-" / ".")

identifier-ref-arg-str = identifier-ref-arg ; < a string that matches the rule identifier-ref-arg >

identifier-ref-arg = [prefix ":"] identifier

string = DQUOTE *( ALPHA / DIGIT / " " / "_" / "-" / "." ) DQUOTE ; < an unquoted string as returned by the scanner >

integer-value = ("-" non-negative-integer-value) / non-negative-integer-value

non-negative-integer-value = "0" / positive-integer-value

positive-integer-value = (non-zero-digit *DIGIT)

zero-integer-value = 1*DIGIT

stmtend = ";" / "{" *unknown-statement "}"

sep = 1*(WSP / line-break) ; unconditional separator

optsep = *(WSP / line-break)

stmtsep = *(WSP / line-break / unknown-statement)

line-break = CRLF / LF

non-zero-digit = %x31-39

decimal-value = integer-value ("." zero-integer-value)

SQUOTE = %x27 ; ' (Single Quote)

ALPHA = %x41-5A / %x61-7A ; A-Z / a-z

CR = %x0D ; carriage return

CRLF = CR LF ; Internet standard new line

DIGIT = %x30-39 ; 0-9

DQUOTE = %x22 ; " (Double Quote)

HEXDIG = DIGIT / %x61 / %x62 / %x63 / %x64 / %x65 / %x66 ; only lower-case a..f

HTAB = %x09 ; horizontal tab

LF = %x0A ; linefeed

SP = %x20 ; space

VCHAR = %x21-7E ; visible (printing) characters

WSP = SP / HTAB ; whitespace

URI = scheme ":" hier-part [ "?" query ] [ "#" fragment ]

hier-part = "//" authority path-abempty / path-absolute / path-rootless / path-empty

URI-reference = URI / relative-ref

absolute-URI = scheme ":" hier-part [ "?" query ]

relative-ref = relative-part [ "?" query ] [ "#" fragment ]

relative-part = "//" authority path-abempty / path-absolute / path-noscheme / path-empty

scheme = ALPHA *( ALPHA / DIGIT / "+" / "-" / "." )

authority = [ userinfo "@" ] host [ ":" port ]
userinfo = *( unreserved / pct-encoded / sub-delims / ":" )
host = IP-literal / IPv4address / reg-name
port = *DIGIT

IP-literal = "[" ( IPv6address / IPvFuture ) "]"

IPvFuture = "v" 1*HEXDIG "." 1*( unreserved / sub-delims / ":" )

IPv6address = 6( h16 ":" ) ls32 / "::" 5( h16 ":" ) ls32 / [ h16 ] "::" 4( h16 ":" ) ls32 / [ *1( h16 ":" ) h16 ] "::" 3( h16 ":" ) ls32 / [ *2( h16 ":" ) h16 ] "::" 2( h16 ":" ) ls32 / [ *3( h16 ":" ) h16 ] "::" h16 ":" ls32 / [ *4( h16 ":" ) h16 ] "::" ls32 / [ *5( h16 ":" ) h16 ] "::" h16 / [ *6( h16 ":" ) h16 ] "::"

h16 = 1*4HEXDIG
ls32 = ( h16 ":" h16 ) / IPv4address
IPv4address = dec-octet "." dec-octet "." dec-octet "." dec-octet

dec-octet = DIGIT ; 0-9 / %x31-39 DIGIT ; 10-99 / "1" 2DIGIT ; 100-199 / "2" %x30-34 DIGIT ; 200-249 / "25" %x30-35 ; 250-255

reg-name = *( unreserved / pct-encoded / sub-delims )

path = path-abempty ; begins with "/" or is empty / path-absolute ; begins with "/" but not "//" / path-noscheme ; begins with a non-colon segment / path-rootless ; begins with a segment / path-empty ; zero characters

path-abempty = *( "/" segment )
path-absolute = "/" [ segment-nz *( "/" segment ) ]
path-noscheme = segment-nz-nc *( "/" segment )
path-rootless = segment-nz *( "/" segment )
path-empty = 0<pchar>

segment = *pchar
segment-nz = 1*pchar
segment-nz-nc = 1*( unreserved / pct-encoded / sub-delims / "@" ) ; non-zero-length segment without any colon ":"

pchar = unreserved / pct-encoded / sub-delims / ":" / "@"

query = *( pchar / "/" / "?" )

fragment = *( pchar / "/" / "?" )

pct-encoded = "%" HEXDIG HEXDIG

unreserved = ALPHA / DIGIT / "-" / "." / "_" / "~"
reserved = gen-delims / sub-delims
gen-delims = ":" / "/" / "?" / "#" / "[" / "]" / "@"
sub-delims = "!" / "$" / "&" / "'" / "(" / ")" / "*" / "+" / "," / ";" / "="
END
