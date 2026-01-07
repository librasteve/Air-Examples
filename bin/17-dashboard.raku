#!/usr/bin/env raku

use Air::Functional :BASE;
use Air::Base;

my $site =
    site :register[Dashboard.new, Panel.new, LightDark.new],
        page #:REFRESH(15),
        [
            header [
                nav :widgets(lightdark);
                h1 'Welcome to My Dashboard';
            ];

            main [
                dashboard [
                    panel :order(1), h2 'Analytics';
                    panel :order(2), h2 'Traffic';
                    panel :order(3), h2 'Comments';
                    panel :order(8), h2 'Quick Draft';
                    panel :order(5), h2 'Recent Activity';
                    panel :order(6), h2 'Site Overview';
                    panel :order(7), h2 'News';
                ];
            ];
        ];
    ;

$site.serve;
