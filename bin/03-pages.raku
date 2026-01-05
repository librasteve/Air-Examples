#!/usr/bin/env raku

use Air::Functional :BASE;
use Air::Base;

class MyPage is Page {
    has $.title       = 'hÅrc';
    has $.description = 'HTMX, Air, Red, Cro';

    has $.footer = Footer.new: p safe Q|
        Hypered with <a href="https://htmx.org" target="_blank">htmx</a>.
        Aloft on <a href="https://github.com/librasteve/Air" target="_blank"><b>&Aring;ir</b></a>.
        Remembered by <a href="https://fco.github.io/Red/" target="_blank">red</a>.
        Constructed in <a href="https://cro.raku.org" target="_blank">cro</a>.
        &nbsp;&amp;&nbsp;
        Styled by <a href="https://picocss.com" target="_blank">picocss</a>.
    |;
}

my %data =
    :thead[["Planet", "Hexameter (km)", "Distance to Sun (AU)", "Orbit (days)"],],
    :tbody[["Mercury",  "4,880", "0.39",  "88"],
           ["Venus"  , "12,104", "0.72", "225"],
           ["Earth"  , "12,742", "1.00", "365"],
           ["Mars"   ,  "6,779", "1.52", "687"],],
    :tfoot[["Average",  "9,126", "0.91", "341"],];

my $page1 = MyPage.new: Main.new:
    div [
        h3 'Page 1';
        table |%data, :class<striped>;
    ];

my $page2 = MyPage.new: Main.new:
    div [
        h3 'Page 2';
        table |%data;
    ];

my $nav = Nav.new:
    logo => span( safe '<a href="/">h<b>&Aring;</b>rc</a>' ),
    items => [Page1 => $page1, Page2 => $page2];

$page1.nav = $page2.nav = $nav;

# site
(Site.new: pages => [$page1, $page2],).serve;
