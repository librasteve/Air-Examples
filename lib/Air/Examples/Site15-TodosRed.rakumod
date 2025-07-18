use Air::Functional :BASE;
use Air::Base;
use Air::Component;

use Red:api<2>; red-defaults “SQLite”;

role HxTodo {
    method hx-create(--> Hash()) {
        :hx-post("todo"),
        :hx-target<table>,
        :hx-swap<beforeend>,
    }
    method hx-delete(--> Hash()) {
        :hx-delete("todo/$.id"),
        :hx-confirm('Are you sure?'),
        :hx-target('closest tr'),
        :hx-swap<delete>,
    }
    method hx-toggle(--> Hash()) {
        :hx-get("todo/$.id/toggle"),
        :hx-target<closest tr>,
        :hx-swap<outerHTML>,
    }
}

model Todo does Component::Red[:C:R:U:D] {
    also does HxTodo;

    has UInt   $.id      is serial;
    has Bool   $.checked is rw is column = False;
    has Str    $.text    is column is required;

    method toggle is controller {
        $!checked = !$!checked;
        $.^save;
        self
    }

    method HTML {
        tr
            td( input :type<checkbox>, |$.hx-toggle, :$!checked ),
            td( $!checked ?? del $!text !! $!text),
            td( button :type<submit>, |$.hx-delete, :style<width:50px>, '-'),
    }
}
Todo.^create-table;

my &index = &page.assuming(
    title       => 'hÅrc',
    description => 'HTMX, Air, Red, Cro',
    footer      => footer p ['Aloft on ', b 'Åir'],
);

for <one two> -> $text { Todo.^create: :$text };

sub SITE is export {
    site :register(Todo),
        index
            main [
                h3 'Todos';
                table Todo.^all;
                form |Todo.hx-create, [
                    input  :name<text>;
                    button :type<submit>, '+';
                ];
            ]
}
