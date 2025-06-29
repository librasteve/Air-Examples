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
        $!count++;
        self
    }

    method hx-increment(--> Hash()) {
        :hx-get("counter/$.id/increment"),
        :hx-target("#counter-$.id"),
        :hx-swap<outerHTML>,
        :hx-trigger<submit>,
    }

    method HTML {
        input :id("counter-$.id"), :name("counter"), :value($!count)
    }
}

my $counter = Counter.new;

sub SITE is export {
    site :register[$counter], #:theme-color<red>,
        index
            main
                form |$counter.hx-increment, [
                    h3 'Counter:';
                    ~$counter;
                    button :type<submit>, '+';
                ]
}
