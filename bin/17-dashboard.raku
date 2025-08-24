#!/usr/bin/env raku

use Air::Functional :BASE;
use Air::Base;

my $site =
    site :register[Dashboard.new, Box.new],
        page #:REFRESH(15),
        [
            header [
                nav :widgets(lightdark);
                h1 'Welcome to My Dashboard';
            ];

            main [
                dashboard [
                    box :order(1), h2 'Analytics';
                    box :order(2), h2 'Traffic';
                    box :order(3), h2 'Comments';
                    box :order(8), h2 'Quick Draft';
                    box :order(5), h2 'Recent Activity';
                    box :order(6), h2 'Site Overview';
                    box :order(7), h2 'News';
                ];
            ];
        ];
    ;

$site.serve;
