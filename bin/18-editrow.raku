#!/usr/bin/env raku

use Air::Functional :BASE;
use Air::Base;
use Air::Component;

class Contact does Component[:R:U] {
    has $.name;
    has $.email;

    multi method data(%h) {  # stores PUT update
        $!name  = %h<name>;
        $!email = %h<email>;
    }

    method edit is controller {
        tr( :hx-trigger<cancel>, :class<editing>, :hx-get("/contact/{$.id}"), [
            td input :autofocus, :name<name>, :value($.name);
            td input :name<email>, :value($.email);
            td [
                button :hx-get("/contact/{$.id}"), 'Cancel';
                button :hx-put("/contact/{$.id}"), :hx-include('closest tr'), 'Save';
            ];
        ])
    }

    my $onClick =
        q:to/END/;
        let editing = document.querySelector('.editing')
        if(editing) {
            Swal.fire({title: 'Already Editing',
            showCancelButton: true,
            confirmButtonText: 'Yep, Edit This Row!',
            text:'Hey!  You are already editing a row!  Do you want to cancel that edit and continue?'})
        .then((result) => {
            if(result.isConfirmed) {
                htmx.trigger(editing, 'cancel')
                htmx.trigger(this, 'edit')
            }
            })
        } else {
            htmx.trigger(this, 'edit')
        }
        END

    multi method HTML {
        tr(
            td $.name;
            td $.email;
            td button :hx-get("/contact/{$.id}/edit"), :hx-trigger<edit>, :$onClick, 'Edit';
        )
    }
}

my @contacts = load-contacts();

class EditTable does Table {
    method STYLE-LINKS  { <https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css> }
    method SCRIPT-LINKS { <https://cdn.jsdelivr.net/npm/sweetalert2@11> }
    method thead {
        <Name Email Action>
    }
    method tbody {
        tbody :hx-target('closest tr'), :hx-swap<outerHTML>, @contacts
    }
}
my $edit-table = EditTable.new;

my &index = &page.assuming(
    title       => 'hÅrc',
    description => 'HTMX, Air, Red, Cro',
    footer      => footer ['Aloft on ', b 'Åir'],
);

my $site =
    site :register[$edit-table, @contacts[0]],
        index
        main
            div [
                h1 'Edit Table';
                $edit-table;
            ];

$site.serve;

sub load-contacts {
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

    my @items;
    for |$data<contacts> {
        @items.append:
            Contact.new:
                name  => .<name>,
                email => .<email>
    }
    @items
}

