#!/usr/bin/env raku

use Air::Functional :BASE;
use Air::Base;
use Air::Plugin::Wordcloud;

my %raku-words =
    Raku      => 10,
    Grammar   =>  8,
    Regex     =>  6,
    HTMX      =>  7,
    Cro       =>  6,
    Air       =>  9,
    Red       =>  5,
    Supply    =>  4,
    Channel   =>  4,
    Promise   =>  5,
    Signature =>  6,
    Dispatch  =>  5,
    Role      =>  7,
    Trait     =>  4,
    Phaser    =>  3,
    Coerce    =>  3,
    Subset    =>  4,
    Whatever  =>  5,
    "»"       =>  9,
    "«"       =>  9,
    "∞"       =>  8,
    "≤"       =>  7,
    "≥"       =>  7,
    "≠"       =>  7,
    "∈"       =>  7,
    "⊂"       =>  6,
    "…"       =>  8,
    "｢｣"      =>  6,
    "π"       =>  7,
    "τ"       =>  6,
    "Å"       =>  8,
;

my &index = &page.assuming(
    nav => nav(
        widgets => [lightdark],
    ),
);

my $site =
site :register[Air::Plugin::Wordcloud.new, LightDark.new],
    index
        main [
            h3 'hArc Stack Word Cloud';
            wordcloud %raku-words, :width(700), :height(400);
            div [
                label [
                    input :type<checkbox>, :id<hv-only>,
                          :onchange("rerenderWC()");
                    safe ' Horizontal &amp; vertical only';
                ];
                label [
                    input :type<checkbox>, :id<fill-field>,
                          :onchange("rerenderWC()");
                    safe ' Fill field';
                ];
            ];
            script q:to/JS/;
                function rerenderWC() {
                    var hvOnly    = document.getElementById('hv-only').checked;
                    var fillField = document.getElementById('fill-field').checked;
                    var opts = Object.assign({}, _wordcloud_1);
                    opts.minRotation  = hvOnly    ? Math.PI/2 : -Math.PI/2;
                    opts.maxRotation  = Math.PI/2;
                    opts.gridSize     = fillField ? 2  : _wordcloud_1.gridSize;
                    opts.weightFactor = fillField ? 18 : _wordcloud_1.weightFactor;
                    WordCloud(document.getElementById('/wordcloud/1'), opts);
                }
                JS
        ]
;

$site.serve;
