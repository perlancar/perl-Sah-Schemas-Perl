package Sah::Schema::perl::filename;

use strict;
use warnings;

# AUTHORITY
# DATE
# DIST
# VERSION

our $schema = [str => {
    summary => 'Filename of Perl script/module/POD, e.g. /path/Foo/Bar.pm',
    description => <<'_',

Use this schema if you want to accept a filesystem path containing Perl script,
module, or POD. The value of this schema is in the convenience of CLI
completion, as well as coercion from script or module name.

String containing filename of a Perl script or module or POD. For convenience,
when value is in the form of:

    Foo
    Foo.pm
    Foo.pod
    Foo::Bar
    Foo/Bar
    Foo/Bar.pm
    Foo/Bar.pod

and a matching .pod or .pm file is found in `@INC`, then it will be coerced
(converted) into the path of that .pod/.pm file, e.g.:

    /home/ujang/perl5/perlbrew/perls/perl-5.24.0/lib/site_perl/5.24.0/Foo/Bar.pm
    lib/Foo/Bar.pod

To prevent such coercion, you can use prefixing path, e.g.:

    ./Foo::Bar
    ../Foo/Bar
    /path/to/Foo/Bar

This schema comes with convenience completion too.

_
    'x.perl.coerce_rules' => [
        'From_str::convert_perl_pm_or_pod_to_path',
    ],
    'x.completion' => sub {
        require Complete::File;
        require Complete::Module;
        require Complete::Util;

        my %args = @_;
        my $word = $args{word};

        my @answers;
        push @answers, Complete::File::complete_file(word => $word);
        if ($word =~ m!\A\w*((?:::|/)\w+)*\z!) {
            push @answers, Complete::Module::complete_module(word => $word);
        }

        Complete::Util::combine_answers(@answers);
    },

}];

1;
# ABSTRACT:

=head1 SEE ALSO

L<Sah::Schema::perl::pm_filename>

L<Sah::Schema::perl::pod_or_pm_filename>

L<Sah::Schema::perl::pod_filename>
