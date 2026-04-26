#!/usr/bin/env raku

use Air::Functional :BASE;
use Air::Base;
use Air::Plugin::RakuDoc;

my &index = &page.assuming(
    title       => 'hÅrc',
    description => 'HTMX, Air, Red, Cro',

    nav => nav(
        logo    => span( safe '<a href="/">h<b>&Aring;</b>rc</a>' ),
        widgets => [lightdark],
    ),

    footer      => footer ['Aloft on ', b 'Åirs'],
);

my $base-examples =
    site :register[Air::Plugin::RakuDoc.new, LightDark.new], :!scss,
        index
        main
            div [

                h1 'regular head';
                h3 'regular head3';
                p 'regular text';
                p em 'emphasis';
                p b 'bold';

                rakudoc q:to/RAKUDOC/;
                    =begin rakudoc :!toc
                    =head Some RakuDoc

                    Lets make a list:
                    =item First item
                    =item Second item
                    =item2 Now a second level
                    =item Back to the first level

                    And now some ordinary text.

                    =end rakudoc
                    RAKUDOC

                hr;

                rakudoc q:to/RAKUDOC/;
                    =begin rakudoc :one-option<first> :another-option(2)

                    =head1 Some tables
                    =head3 A RakuDoc v2 Feature

                    =for table :caption<A visual table> :headlevel(2)
                        Animal | Legs |    Eats
                        =======================
                        Zebra  +   4  + Cookies
                        Human  +   2  +   Pizza
                        Shark  +   0  +    Fish

                    =for table :caption<A visual table with a stupendously long caption> :headlevel(2)
                        Animal | Legs |    Eats
                        =======================
                        Zebra  +   4  + Cookies
                        Human  +   2  +   Pizza
                        Shark  +   0  +    Fish

                    =begin table :caption<A procedural table> :headlevel(2)
                        =row :header
                            =for cell :row-span(2)
                            Date
                            =for cell :column-span(3)
                            Samples
                            =for cell :row-span(2)
                            Mean
                        =row :header
                            =cell I<Sample 1>
                            =cell I<Sample 2>
                            =cell I<Sample 3>
                        =row
                        =column
                            =cell 2023-03-08
                            =cell 2023-04-14
                            =cell 2023-06-23
                        =column
                            =cell 0.4
                            =cell 0.8
                            =cell 0.2
                        =column
                            =cell 0.1
                            =cell 0.6
                            =cell 0.9
                        =column
                            =cell 0.3
                            =cell 0.5
                            =cell 0.0
                        =column
                            =cell 0.26667
                            =cell 0.63333
                            =cell 0.36667
                        =row
                            =for cell :label
                            Mean:
                            =cell 0.46667
                            =cell 0.53333
                            =cell 0.26667
                            =cell 0.42222
                    =end table
                    =end rakudoc
                    RAKUDOC

                rakudoc q:to/RAKUDOC/;
                    =begin pod

                    =head1 Air

                    Breathing life into the raku B<hArc stack> (HTMX, Air, Red, Cro).

                    B<Air> aims to be the purest possible expression of L<HTMX|https://htmx.org>.

                    B<hArc> websites are written in functional code. This puts the emphasis firmly onto the content and layout of the site,
                    rather than boilerplate markup that can often obscure the intention.

                    B<Air> is basically a set of libraries that produce HTML code and serve it using Cro.

                    The result is a concise, legible and easy-to-maintain website codebase.


                    =head1 SYNOPSIS

                    =begin code :lang<raku>
                    #!/usr/bin/env raku

                    use Air::Functional :BASE;
                    use Air::Base;

                    my &index = &page.assuming( #:REFRESH(1),
                        title       => 'hÅrc',
                        description => 'HTMX, Air, Red, Cro',
                        footer      => footer p ['Aloft on ', b safe '&Aring;ir'],
                    );


                    my &planets = &table.assuming(
                        :thead[["Planet", "Diameter (km)",
                                "Distance to Sun (AU)", "Orbit (days)"],],
                        :tbody[["Mercury",  "4,880", "0.39",  "88"],
                               ["Venus"  , "12,104", "0.72", "225"],
                               ["Earth"  , "12,742", "1.00", "365"],
                               ["Mars"   ,  "6,779", "1.52", "687"],],
                        :tfoot[["Average",  "9,126", "0.91", "341"],],
                    );


                    sub SITE is export {
                        site #:bold-color<blue>,
                            index
                                main
                                    div [
                                        h3 'Planetary Table';
                                        planets;
                                    ]
                    }
                    =end code


                    =head1 GETTING STARTED

                    Install raku - eg. from L<rakubrew|https://rakubrew.org>, then:

                    =begin code
                    Install Air, Cro & Red
                    - zef install --/test cro
                    - zef install Red --exclude="pq:ver<5>"
                    - zef install Air

                    Run and view some examples
                    - git clone https://github.com/librasteve/Air-Examples.git && cd Air-Examples
                    - export WEBSITE_HOST="0.0.0.0" && export WEBSITE_PORT="3000"
                    - raku -Ilib service.raku
                    - browse to http://localhost:3000
                    =end code

                    Cro has many other options as documented at L<Cro|https://cro.raku.org> for deployment to a production server.


                    =head1 DESCRIPTION

                    Air is not a framework, but a set of libraries. Full control over the application loop is retained by the coder.

                    Air does not provide an HTML templating language, instead each HTML tag is written as a subroutine call where the argument is a list of C<@inners> and attributes are passed via the raku Pair syntax C<:name<value>>. L<Cro templates|https://cro.raku.org/docs/reference/cro-webapp-template-syntax> are great if you would rather take the template approach.

                    Reusability is promoted by the structure of the libraries - individuals and teams can create and install your own libraries to encapsulate design themes, re-usable web components and best practice.

                    Air is comprised of four core libraries:

                    =item [Air::Functional](Air/Functional.md) - wraps HTML tags as functions
                    =item [Air::Base](Air/Base.md) - a set of handy prebuilt components
                    =item [Air::Component](Air/Component.md) - make your own components
                    =item [Air::Form](Air/Form.md) - declarative forms

                    Air also has a plugin system, for example:
                    =item Air::Plugin::Hilite - code highlighter

                    B<L<Air::Examples|https://raku.land/zef:librasteve/Air::Examples>> is a companion raku module with various B<Air> website examples.

                    The Air documentation is at L<https://librasteve.github.io/Air>


                    =head1 TIPS & TRICKS

                    =item When debugging, use the raku C<note> sub to out put debuggin info to stderr (ie in the Cro Log stream)
                    =item When passing a 2D Array to a tag function, make sure that there is a trailing comma C<:tbody[["Mercury",  "4,880", "0.39",  "88"],]>
                    =item An error message like I<insufficient arguments> is often caused by separating two tag functions with a comma C<,> instead of a semicolon C<;>
                    =item In development set CRO_DEV=1 in the L<environment|https://cro.services/docs/reference/cro-webapp-template#Template_auto-reload>


                    =head1 AUTHOR

                    Steve Roe <librasteve@furnival.net>

                    The `Air::Component` module provided is based on an early version of the raku `Cromponent` module, author Fernando Corrêa de Oliveira <fco@cpan.com>, however unlike Cromponent this module does not use Cro Templates.


                    =head1 COPYRIGHT AND LICENSE

                    Copyright(c) 2025 Henley Cloud Consulting Ltd.

                    This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

                    =end pod
                    RAKUDOC

            ];

$base-examples.serve;