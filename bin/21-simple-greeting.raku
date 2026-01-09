#!/usr/bin/env raku

#this example inspired by https://lit.dev/playground/

use Air::Functional :BASE;
use Air::Base;

my $site =
    site
        page
            main
                p el 'simple-greeting', :name<John>, [span 'yo'; span 'ho'];

$site.serve;
