use Air::Functional :BASE;
use Air::Base;
use Air::Component;

use Air::Examples::SearchTable;

my &index = &page.assuming( #:REFRESH(1),
    title       => 'hÅrc',
    description => 'HTMX, Air, Red, Cro',
    footer      => footer p ['Aloft on ', b 'Åir'],
);


sub SITE is export {
    site :register[SearchTable.new],
        index
            main
                div [
                    searchtable :id(0)
                ]
}
