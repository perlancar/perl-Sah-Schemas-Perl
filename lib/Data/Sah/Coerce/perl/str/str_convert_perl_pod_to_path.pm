package Data::Sah::Coerce::perl::str::str_convert_perl_pod_to_path;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

sub meta {
    +{
        v => 2,
        enable_by_default => 0,
        might_die => 0,
        prio => 50,
    };
}

sub coerce {
    my %args = @_;

    my $dt = $args{data_term};

    my $res = {};

    $res->{modules}{'Module::Path::More'} //= 0;
    $res->{expr_match} = "1";
    $res->{expr_coerce} = join(
        "",
        "do { ",
        "my \$_sahc_orig = $dt; ",
        "if (\$_sahc_orig =~ m!\\A\\w+((?:/|::)\\w+)*(?:\\.pod)?\\z!) {",
        "  (my \$tmp = \$_sahc_orig) =~ s!/!::!g; my \$ext; \$tmp =~ s/\\.(pod)\\z// and \$ext = \$1;",
        "  Module::Path::More::module_path(module=>\$tmp, find_pm=>0, find_pod=>!\$ext || \$ext eq 'pod', find_prefix=>0, find_pmc=>0) || \$_sahc_orig ",
        "} else {",
        "  \$_sahc_orig ",
        "} ",
        "}",
    );

    $res;
}

1;
# ABSTRACT: Convert POD name existing in @INC to its filesystem path

=for Pod::Coverage ^(meta|coerce)$

=head1 DESCRIPTION

This rule can convert strings in the form of:

 Foo::Bar
 Foo/Bar
 Foo/Bar.pod

into the filesystem path (e.g.
C</home/ujang/perl5/perlbrew/perls/perl-5.24.0/lib/site_perl/5.24.0/Foo/Bar.pod>)
when the POD exists in C<@INC>. Otherwise, it leaves the string as-is.
