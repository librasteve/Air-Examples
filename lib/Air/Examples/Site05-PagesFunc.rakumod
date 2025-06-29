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


sub SITE is export {site :@pages}
