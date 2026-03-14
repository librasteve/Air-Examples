#!/usr/bin/env raku

use Air::Functional :BASE;
use Air::Base;

my Page $Page1 =
    page
        main
            div [
                h3 'Page 1';
            ];

my Page $Page2 =
    page
        main
            div [
                h3 'Page 2';
            ];

my Nav $nav =
    nav
        items => [:$Page1, :$Page2],

my Page @pages = [$Page1, $Page2];
{ .nav = $nav } for @pages;

site(:@pages).serve;

