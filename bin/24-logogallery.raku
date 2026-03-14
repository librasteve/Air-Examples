#!/usr/bin/env raku

use Air::Functional :BASE;
use Air::Base;

my &index = &page.assuming(
    title       => 'hÅrc',
    description => 'HTMX, Air, Red, Cro',
    footer      => footer ['Aloft on ', b 'Åir'],
);

my $logo-path = '../static/logos';
my $original  = 'original';
my $adjusted  = 'adjusted';
my @logo-files;

@logo-files  = dir( "$logo-path/$original" );
@logo-files .= map( *.basename );
@logo-files .= grep( * !~~ /^ '.'/ );
@logo-files .= sort;

for @logo-files -> $filename {
    my $src = "$logo-path/$original/$filename";
    my $tgt = "$logo-path/$adjusted/$filename";
    qqx`magick $src -resize 100x60 $tgt`;
}

my @logo-anchors =
    [
        for @logo-files {
            a( img :src("$logo-path/$adjusted/$_") ) .HTML;
        }
    ];

say @logo-anchors;


my $base-examples =
    site
    index
        main
        div [
            h3 'Grid';
            hr;
            grid :cols(8), @logo-anchors;
            hr;
        ];



$base-examples.serve;

