#!/usr/bin/env raku

use Air::Functional :BASE;
use Air::Base;

### PAGE TEMPLATE ###

class MyPage is Page {
    has Str $.title       = 'hÅrc';
    has Str $.description = 'HTMX, Air, Red, Cro';

    has Footer $.footer = footer(
        p safe Q|
        Hypered with <a href="https://htmx.org" target="_blank">htmx</a>.
        Aloft on <a href="https://github.com/librasteve/Air" target="_blank"><b>&Aring;ir</b></a>.
        Remembered by <a href="https://fco.github.io/Red/" target="_blank">red</a>.
        Constructed in <a href="https://cro.raku.org" target="_blank">cro</a>.
        &nbsp;&amp;&nbsp;
        Styled by <a href="https://picocss.com" target="_blank">picocss</a>.
    |),
}
sub mypage(*@a, *%h) { MyPage.new( |@a, |%h ) };

### SITE TEMPLATE ###

role MyDefaults {
    multi method defaults(Head:) {
        self.metas.append: Meta.new: :charset<utf-8>;
        self.metas.append: Meta.new: :name<viewport>, :content('width=device-width, initial-scale=1');
        self.links.append: Link.new: :rel<icon>, :href</img/favicon.ico>, :type<image/x-icon>;
#        self.links.append: Link.new: :rel<stylesheet>, :href</css/styles.css>;
        self.scripts.append: Script.new: :src<https://unpkg.com/htmx.org@1.9.5>, :crossorigin<anonymous>,
            :integrity<sha384-xcuj3WpfgjlKF+FXhSQFQ0ZNr39ln+hwjN3npfM9VBnUskLolQAcN80McRIVOPuO>;
    }
}

class MySite is Site does MyDefaults {

}
sub mysite(*@a, *%h) { MySite.new( |@a, |%h ) };



### SITE CONTENT ###

sub planets(--> Hash) { {
    :thead[["Planet", "Hexameter (km)", "Distance to Sun (AU)", "Orbit (days)"],],
    :tbody[["Mercury",  "4,880", "0.39",  "88"],
           ["Venus"  , "12,104", "0.72", "225"],
           ["Earth"  , "12,742", "1.00", "365"],
           ["Mars"   ,  "6,779", "1.52", "687"],],
    :tfoot[["Average",  "9,126", "0.91", "341"],]
} }

my Page $Page1 =
    mypage
    main
        div [
            h3 'Page 1';
            table |planets, :class<striped>;
        ];

my Page $Page2 =
    mypage
    main
        div [
            h3 'Page 2';
            table |planets;
        ];

my Nav $nav =
    nav
    logo => span( safe '<a href="/">h<b>&Aring;</b>rc</a>' ),
        items => [:$Page1, :$Page2],
        widgets => [lightdark];

my Page @pages = [$Page1, $Page2];
{ .nav = $nav } for @pages;

.serve given (mysite :@pages);

