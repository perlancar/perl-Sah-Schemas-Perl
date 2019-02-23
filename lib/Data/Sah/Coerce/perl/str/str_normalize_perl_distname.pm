package Data::Sah::Coerce::perl::str::str_normalize_perl_distname;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

sub meta {
    +{
        v => 4,
        prio => 50,
    };
}

sub coerce {
    my %args = @_;

    my $dt = $args{data_term};

    my $res = {};

    $res->{expr_match} = "1";
    $res->{expr_coerce} = join(
        "",
        "do { my \$tmp = $dt; \$tmp = \$1 if \$tmp =~ m!\\A(\\w+(?:/\\w+)*)\.pm\\z!; \$tmp =~ s!::?|/|\\.!-!g; \$tmp }",
    );

    $res;
}

1;
# ABSTRACT: Coerce perl::distname from str

=for Pod::Coverage ^(meta|coerce)$

=head1 DESCRIPTION

This rule can normalize strings in the form of:

 Foo/Bar.pm
 Foo::Bar
 Foo:Bar
 Foo/Bar
 Foo.Bar

into:

 Foo-Bar
