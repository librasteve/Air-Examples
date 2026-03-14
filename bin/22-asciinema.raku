#!/usr/bin/env raku

use Air::Functional :BASE;
use Air::Base;
use Air::Plugin::Asciinema;

my $site =
site :register[Air::Plugin::Asciinema.new],
    page
        main [
            div [
                h3 '1. Arithmetic';
                asciinema '/static/demos/demo1.cast';
            ];
            div [
                h3 '2. Powers & Roots';
                asciinema '/static/demos/demo2.cast';
            ];
        ]
;

$site.serve;
