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

my %logos = (
    'atikon-logo.png'           => 'https://www.atikon.com',
    'cns-logo.png'              => '',
    'edument-logo.png'          => 'https://www.edument.se',
    'haltec-logo.png'           => 'https://www.haltec.net',
    'oetiker_partner-logo.png'  => 'https://www.oetiker.ch/en_US',
    'qbrc-logo.jpg'             => 'https://qbrc.swmed.edu',
    'virtual_blue-logo.png'     => 'https://virtual.blue',
);

my $base-examples = site :register[Logos.new, LightDark.new], index main
    div [
        h5 'Sponsors';
        logos :%logos;
        hr;
    ];

$base-examples.serve;
