#!/usr/bin/env raku

use Air::Functional :BASE;
use Air::Base;
use Air::Plugin::RakuDoc;

my &index = &page.assuming(
    title       => 'hÅrc',
    description => 'HTMX, Air, Red, Cro',

    nav => nav(
        logo    => span( safe '<a href="/">h<b>&Aring;</b>rc</a>' ),
        widgets => [lightdark],
    ),

    footer      => footer ['Aloft on ', b 'Åirs'],
);

my $base-examples =
    site :register[Air::Plugin::RakuDoc.new, LightDark.new], :!scss,
        index
        main
            div [
                rakudoc q:to/RAKUDOC/;
                    =begin rakudoc :!toc
                    =config item :bullet«\c[palm tree]»
                    =config item2 :bullet«\c[Earth Globe Europe-Africa]»
                    =head Some RakuDoc v2
                    =head2 Subheading

                    Lets include a snazzy list:
                    =item First item with a palm tree bullet
                    =item Second item with palm tree
                    =item2 Now a second layer with a world
                    =item Back to the palm tree

                    And now some ordinary text.
                    =end rakudoc
                    RAKUDOC

                hr;

                rakudoc q:to/RAKUDOC/;
                    =begin rakudoc :one-option<first> :another-option(2)

                    =head Some tables

                    =for table :caption<A visual table> :headlevel(2)
                        Animal | Legs |    Eats
                        =======================
                        Zebra  +   4  + Cookies
                        Human  +   2  +   Pizza
                        Shark  +   0  +    Fish

                    =for table :caption<A visual table with a stupendously long caption> :headlevel(2)
                        Animal | Legs |    Eats
                        =======================
                        Zebra  +   4  + Cookies
                        Human  +   2  +   Pizza
                        Shark  +   0  +    Fish

                    =begin table :caption<A procedural table> :headlevel(2)
                        =row :header
                            =for cell :row-span(2)
                            Date
                            =for cell :column-span(3)
                            Samples
                            =for cell :row-span(2)
                            Mean
                        =row :header
                            =cell I<Sample 1>
                            =cell I<Sample 2>
                            =cell I<Sample 3>
                        =row
                        =column
                            =cell 2023-03-08
                            =cell 2023-04-14
                            =cell 2023-06-23
                        =column
                            =cell 0.4
                            =cell 0.8
                            =cell 0.2
                        =column
                            =cell 0.1
                            =cell 0.6
                            =cell 0.9
                        =column
                            =cell 0.3
                            =cell 0.5
                            =cell 0.0
                        =column
                            =cell 0.26667
                            =cell 0.63333
                            =cell 0.36667
                        =row
                            =for cell :label
                            Mean:
                            =cell 0.46667
                            =cell 0.53333
                            =cell 0.26667
                            =cell 0.42222
                    =end table
                    =end rakudoc
                    RAKUDOC

            ];

$base-examples.serve;