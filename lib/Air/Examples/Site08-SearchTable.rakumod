use Air::Functional :BASE;
use Air::Base;
use Air::Component;

my &index = &page.assuming( #:REFRESH(1),
    title       => 'hÅrc',
    description => 'HTMX, Air, Red, Cro',
    footer      => footer p ['Aloft on ', b 'Åir'],
);

use Air::Examples::SearchTable;

sub SITE is export {
    site :register[SearchTable.new],
        index
            main
                searchtable :id(0)
}
