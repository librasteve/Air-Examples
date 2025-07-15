use Air::Functional :BASE;
use Air::Base;
use Air::Component;

my $data = { contacts => [
    {
        name => "Joe Smith",
        email => "joe@smith.org",
    },
    {
        name => "Angie MacDowell",
        email => "angie@macdowell.org",
    },
    {
        name => "Fuqua Tarkenton",
        email => "fuqua@tarkenton.org",
    },
    {
        name => "Kim Yee",
        email => "kim@yee.org",
    },
]};

{ .<id> = $++ } for |$data<contacts>;

class EditTable does Table {
    method thead { [<Name Email>,] }
    method tbody { [{ .<name>, .<email> } for |$data<contacts>] }

}
sub edittable(*@a, *%h) { EditTable.new( |@a, |%h ) };

my &index = &page.assuming( #:REFRESH(1),
    title       => 'hÅrc',
    description => 'HTMX, Air, Red, Cro',
    footer      => footer p ['Aloft on ', b 'Åir'],
    );

sub SITE is export {
    site :register[EditTable.new],
        index
            main
                div [
                    h1 'Edit Table';
                    edittable;
                ]
}
