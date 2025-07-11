use Air::Functional :BASE;
use Air::Base;
use Air::Component;
use Air::Plugin::Hilite;

my $htmx = external :href<https://htmx.org>;
my $air  = external :href<https://github.com/librasteve/Air>;
my $red  = external :href<https://github.com/FCO/Red>;
my $cro  = external :href<https://cro.raku.org>;
my $raku = external :href<https://raku.org>;
my $talk = external :href<https://discord.gg/VzYpdQ6>;

my &index = &page.assuming( #:REFRESH(15),
    title => 'hÅrc',
    description => 'HTMX, Air, Red, Cro',

    nav => nav(
        logo    => span( safe '<a href="/">h<b>&Aring;</b>rc</a>' ),
        items   => [:$htmx,:$air,:$red,:$cro,:$raku,:$talk],
        widgets => [lightdark],
    ),

    footer => footer(
        p safe Q|
        Hypered with <a href="https://htmx.org" target="_blank">htmx</a>.
        Aloft on <a href="https://github.com/librasteve/Air" target="_blank"><b>&Aring;ir</b></a>.
        Remembered by <a href="https://fco.github.io/Red/" target="_blank">red</a>.
        Constructed in <a href="https://cro.raku.org" target="_blank">cro</a>.
        &nbsp;&amp;&nbsp;
        Styled by <a href="https://picocss.com" target="_blank">picocss</a>.
    |),
);

my @tools = [Analytics.new: :provider(Umami), :key<35777f61-5123-4bb8-afb1-aced487af36e>,];


sub SITE is export {

    site :theme-color<azure>, :bold-color<maroon>, :@tools, :register[Air::Plugin::Hilite.new],
        index
        main [
            div [
                h2 'The hArc Stack';
                p  'Combining HTMX with raku Air, Red and Cro so that you can ',
                    em 'just build websites the right way', '.';

                hilite example-code;
                markdown main-txt;
            ];
        ];
}

sub example-code {
    q:to/END/;
    use Air::Functional :BASE;
    use Air::Base;
    use Air::Component;

    my &index = &page.assuming( #:REFRESH(5),
        title       => 'hÅrc',
        description => 'HTMX, Air, Red, Cro',
        footer      => footer p ['Aloft on ', b 'Åir'],
    );

    class Counter does Component {
        has Int $.count = 0;

        method increment is controller {
            $.count++;
            self
        }

        method hx-increment(--> Hash()) {
            :hx-get("$.url-path/increment"),
            :hx-target("#$.html-id"),
            :hx-swap<outerHTML>,
            :hx-trigger<submit>,
        }

        method HTML {
            input :id($.html-id), :name<counter>, :value($.count)
        }
    }

    my $counter = Counter.new;

    sub SITE is export {
        site :register[$counter], #:theme-color<red>,
            index
                main
                    form |$counter.hx-increment, [
                        h3 'Counter:';
                        $counter;
                        button :type<submit>, '+';
                    ]
    }
    END
}

sub main-txt {

q:to/END/;
hArc stands for "HTMX, Air, Red, Cro" - the [Air](https://raku.land/zef:librasteve/Air) raku module is the "glue" that makes the stack. There's also the [Air::Examples](https://raku.land/zef:librasteve/Air::Examples) module for website examples and Getting Started instructions.

---

## HTMX: Server Side

HTMX provides server side website code with the dynamic and attractive UX of a reactive JavaScript SPA. It extends HTML with attributes like:

  - `hx-get="/data"` → Fetches data via GET.
  - `hx-post="/submit"` → Submits a form via POST.
  - `hx-target="#result"` → Updates a specific part of the page.
  - `hx-swap="outerHTML"` → Controls how content is replaced.

It's a lightweight, declarative way to enhance interactivity while keeping your application state and server code simple.

---

## Air: Code Clarity

Air aims to be the purest possible expression of HTMX, ensuring that hArc websites are built with a focus on content and layout rather than embedded markup. By embracing a functional coding style for composition, Air improves code clarity. It consists of a set of libraries that generate HTML and serve it via Cro, that results in concise, legible, and maintainable web applications.

---

## Red: Data Model

Red is a powerful ORM (Object-Relational Mapper) for raku that provides an intuitive way to interact with databases. It supports various database backends and enables developers to model their data using raku’s expressive type system. Red simplifies database operations with a declarative syntax, making it easy to define schemas, query data, and perform complex transactions while maintaining the flexibility and safety of raku’s type system.

---

## Cro: Web Services

Cro is raku’s leading solution for building web applications, offering a modular framework for creating HTTP applications, APIs, and real-time services. It provides a powerful and extensible pipeline-based architecture, making it easy to build scalable and maintainable applications. Cro’s built-in support for WebSockets, middleware, and async processing ensures that hArc applications can handle real-time interactions efficiently.

---

## Raku: Language Toolkit

With support for functional, object-oriented, and reactive programming paradigms, raku is a  language toolkit for developers to build concise and maintainable websites. A powerful concurrency model, grammars, and metaprogramming capabilities make it well-suited for more advanced web applications. This gradually-typed scripting language makes easy things easy and hard things possible.'

_~librasteve_
END

}
