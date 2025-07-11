use Air::Functional :BASE;
use Air::Base;
use Air::Component;

my &index = &page.assuming(
    title       => 'hÅrc',
    description => 'HTMX, Air, Red, Cro',
    footer      => footer p ['Aloft on ', b 'Åir'],
);

sub SITE is export {
    site :register[Tabs.new, Lightbox.new, Dialog.new], #:theme-color<blue>,
        index #:REFRESH(5),
            main
                div [
                    h3 'Button';
                    div :role<group>,
                        [
                            button 'Button';
                            button :class<secondary>, 'Secondary';
                            button :class<contrast>,  'Contrast';
                            button :class('secondary outline'), 'Outline';
                            button :class<outline>, :disabled, 'Disabled';
                        ];
                    hr;
#
                    h3 'Table';
                    table [[1,2],[3,4]], :thead[<Left Right>,];
                    hr;

                    h3 'Grid';
                    grid :cols(5), [span $_ for 1..17];
                    hr;

                    h3 'Flexbox';
                    flexbox [span $_ for 1..34];
                    hr;

                    h3 'Markdown';
                    markdown q:to/END/;
                        # My Markdown Example

                        ## Subheading

                        **Bold text** and *italic text*.

                        Here's a [link](https://www.example.com).

                         - Item 1
                         - Item 2
                         - Item 3

                        > This is a blockquote.

                        `Inline code` is useful!
                        END
                    hr;

                    h3 'Tabs';
                    tabs [
                        Tab1 => tab p "tada";
                        Tab2 => tab p "yoda";
                        Tab3 => tab p "coda";
                    ];
                    hr;

                    h3 'Lightbox';
                    lightbox [button 'hit me'; h1 'lightbox'; p 'ipso facto'];
                    hr;

                    h3 'Dialog (wip)';
                    dialog;
                    hr;

                ]
}

