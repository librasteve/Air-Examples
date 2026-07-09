#!/usr/bin/env raku

use Air::Functional :BASE;
use Air::Base;
use Air::Plugin::RakuDoc;

my &index = &page.assuming(
    title       => 'hÅrc',
    description => 'HTMX, Air, Red, Cro',
    footer      => footer p ['Aloft on ', b 'Åir'],
    );

my $base-examples =
    site :register[Air::Plugin::RakuDoc.new], :!scss,
        index
        main
            div [
                h3 'RakuDoc';
                rakudoc q:to/RAKUDOC/;
                    =document :!auto-toc
                    =begin rakudoc
                    =config item :bullet«\c[palm tree]»
                    =config item2 :bullet«\c[Earth Globe Europe-Africa]»
                    =head This is some RakuDoc source

                    Lets include a snazzy list:
                    =item First item with a palm tree bullet
                    =item Second item with palm tree
                    =item2 Now a second layer with a world
                    =item Back to the palm tree

                    And now some ordinary text.
                    =end rakudoc
                    RAKUDOC
                    hr;

            ];

$base-examples.serve;