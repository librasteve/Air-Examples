#!/usr/bin/env raku

use Air::Functional :BASE;
use Air::Base;

my $nano =
    site
        page
            main
                p "Yo baby!";

$nano.serve;