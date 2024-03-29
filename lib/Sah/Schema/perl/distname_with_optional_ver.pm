package Sah::Schema::perl::distname_with_optional_ver;

use strict;
use warnings;

# AUTHORITY
# DATE
# DIST
# VERSION

our $schema = [str => {
    summary => 'Perl distribution name (e.g. Foo-Bar) with optional version number suffix (e.g. Foo-Bar@0.001)',
    match => '\A[A-Za-z_][A-Za-z_0-9]*(-[A-Za-z_0-9]+)*(@[0-9][0-9A-Za-z]*(\\.[0-9A-Za-z_]+)*)?\z',
    'x.perl.coerce_rules' => [
        'From_str::normalize_perl_distname',
    ],

    # provide a default completion which is from list of installed perl distributions
    'x.completion' => 'perl_distname',

    description => <<'_',

For convenience (particularly in CLI with tab completion), you can input one of:

    Foo::Bar
    Foo/Bar
    Foo/Bar.pm
    Foo.Bar

and it will be coerced into Foo-Bar form.

_

    examples => [
        {value=>'', valid=>0},
        {value=>'Foo-Bar', valid=>1},
        {value=>'Foo-Bar@1', valid=>1},
        {value=>'Foo-Bar@1.0', valid=>1},
        {value=>'Foo::Bar@1.0.0', valid=>1, validated_value=>'Foo-Bar@1.0.0'},
        {value=>'Foo-Bar@0.5_001', valid=>1},
        {value=>'Foo::Bar@0.5_001', valid=>1, validated_value=>'Foo-Bar@0.5_001'},
        {value=>'Foo-Bar@a', valid=>0},
    ],

}];

1;
# ABSTRACT:
