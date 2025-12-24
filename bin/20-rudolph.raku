#!/usr/bin/env raku

use Air::Functional :BASE;
use Air::Base;

my &rude-div = &div.assuming(
    :style( q:to/END/;
        background: rgba(179, 0, 0, 0.75);
        color: white;
        padding: 2rem;
        text-align: center;
        border-radius: 10px;
        END
    ),
);

my &shadow = &background.assuming(
    :src<https://freesvg.org/img/1360260438.png>,
    :top(400),
    :rotate(0),
);

my &rude-art = &article.assuming(
    style => "background-color:rgba(128,128,128,0.2)"
);

my &index = &page.assuming(
    title => 'Rudi',
    nav => nav(
        logo => img( :src<https://rakuadventcalendar.wordpress.com/wp-content/uploads/2022/01/cropped-camelia-small-santa1-e1638808175784.png>, :width<60px>),
        widgets => [lightdark],
    ),
    footer => footer p [safe '&copy; 2025'; b 'Rudolph.'; 'All rights reserved.'],
);

my $rudi =
site :register(shadow), index [
    main [
        shadow;
        rude-div [
            h1 'Rudolph';
            p 'Developer • Tinkerer • Occasional Cookie Enthusiast';
        ];
        spacer;
        rude-art markdown q:to/END/;
        ## About Me

        Hello! I'm Rudolph, a curious builder who loves working on small
        tools, playful experiments, and simple things that make life easier.
        I enjoy long walks, warm drinks, and the feeling of figuring
        something out after staring at it way too long.

        END
        rude-art markdown q:to/END/;
        ## Projects

        - *ChimeBox:* a tiny notification app that whispers instead of buzzes.

        - *TrailMapper:* a map tool for discovering quiet paths around my city.

        - *CookieCrunch:* a deliberately pointless game about collecting virtual cookies.

        END
        rude-art markdown q:to/END/;
        ## Contact

        If you'd like to say hello, send a message via <b>rudolph at example.com</b>

        END
    ];
];

$rudi.serve;