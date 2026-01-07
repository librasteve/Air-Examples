#!/usr/bin/env raku


use Air::Functional :BASE;
use Air::Base;
use Air::Component;

use Red:api<2>; red-defaults “SQLite”;

my &index = &page.assuming(
    title       => 'hÅrc',
    description => 'HTMX, Air, Red, Cro',
    footer      => footer ['Aloft on ', b 'Åir'],
    );

model Counter does Component::Red {
    has UInt  $.id     is serial;
    has Int   $.count  is rw is column(:default{0});

    method increment is controller {
        $!count++;
        $.^save;
        self
    }

    method hx-increment(--> Hash()) {
        :hx-get("$.url-path/increment"),
        :hx-target("#$.html-id"),
        :hx-swap<outerHTML>,
        :hx-trigger<submit>,
    }

    method HTML {
        input :id($.html-id), :name<counter>, :value($.count)
    }
}
Counter.^create-table;

my $counter = Counter.^create;

my $site =
    site :register[$counter], #:theme-color<red>,
        index
        main
            form |$counter.hx-increment, [
                h3 'Counter:';
                ~$counter;
                button :type<submit>, '+';
            ];

$site.serve;

