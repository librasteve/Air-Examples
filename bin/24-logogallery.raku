#!/usr/bin/env raku

use Air::Functional :BASE;
use Air::Base;

my &index = &page.assuming(
    title       => 'hÅrc',
    description => 'HTMX, Air, Red, Cro',

    nav => nav(
        logo    => span( safe '<a href="/">h<b>&Aring;</b>rc</a>' ),
        widgets => [lightdark],
    ),

    footer      => footer ['Aloft on ', b 'Åirs'],
);

my $logo-path = '../static/logos';
my $original  = 'original';
my $adjusted  = 'adjusted';

my %logos = (
    'atikon-logo.png'           => 'https://www.atikon.com',
    'cns-logo.png'              => '',
    'edument-logo.png'          => 'https://www.edument.se',
    'haltec-logo.png'           => 'https://www.haltec.net',
    'oetiker_partner-logo.png'  => 'https://www.oetiker.ch/en_US',
    'qbrc-logo.jpg'             => 'https://qbrc.swmed.edu',
    'virtual_blue-logo.png'     => 'https://virtual.blue',
);

my @logo-files = %logos.keys.sort;

for @logo-files -> $filename {
    my $src = "$logo-path/$original/$filename";
    my $tgt = "$logo-path/$adjusted/$filename";
    qqx`magick $src -resize 100x40 $tgt`;
}

my @logo-anchors =
    [
        for @logo-files {
            a( :href(%logos{$_}), img :src("$logo-path/$adjusted/$_") ) .HTML;
        }
    ];

my %grid-attrs = (
    :justify-items<center>,
    :align-items<center>,
    :background-color<silver>,
    :padding<10px>,
);

my $base-examples = site :register[Grid.new, LightDark.new], index main
    div [
        h5 'Sponsors';
        grid
            :cols(+%logos),
            :gap(1),
            :attrs(%grid-attrs),
            @logo-anchors;
        hr;
    ];

$base-examples.serve;
