#!/usr/bin/env raku

use Air::Functional :BASE;
use Air::Base;

my &index = &page.assuming(
    title       => 'LeftMenu',
    description => 'Left sidebar navigation example',

    nav => nav(
        logo    => span( safe '<a href="/">Air</a>' ),
        widgets => [lightdark],
    ),

    footer => footer p safe '&copy; 2025 Air Docs',
);

my $site =
    site :register[LeftMenu.new, LightDark.new],
        index
        main
            leftmenu [
                :Overview( content [
                    h2 'Overview';
                    p  'Air is a Raku web framework built on Cro, HTMX, and Pico CSS.';
                    p  'It provides a set of composable components for building modern, '
                     ~ 'semantic web pages with minimal boilerplate.';
                    img :src<img/layout.gif>;
                ]),
                :Features( content [
                    h2 'Features';
                    ul [
                        li 'Semantic HTML via Pico CSS';
                        li 'HTMX-powered SPA navigation';
                        li 'Composable Page and Component roles';
                        li 'Built-in dark/light mode toggle';
                        li 'Responsive layouts out of the box';
                    ];
                ]),
                :Usage( content [
                    h2 'Usage';
                    p  'Install Air via zef:';
                    pre code 'zef install Air';
                    p  'Then create a site with a LeftMenu:';
                    pre code q:to/END/;
                        use Air::Functional :BASE;
                        use Air::Base;

                        site
                            page
                            main
                                leftmenu [
                                    :Intro( content div h2 'Hello' ),
                                ]
                        .serve;
                        END
                ]),
                :API( content [
                    h2 'API Reference';
                    table
                        :thead[['Attr', 'Type', 'Default', 'Description'],],
                        :tbody[
                            ['items',   'LeftMenuItem[]', '[]',       'Navigation content pairs'  ],
                            ['hx-swap', 'Str',            'innerHTML', 'HTMX swap strategy'       ],
                        ];
                ]),
            ];

$site.serve;
