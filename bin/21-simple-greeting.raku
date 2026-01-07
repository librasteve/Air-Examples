#!/usr/bin/env raku

#this example inspired by https://lit.dev/playground/

use Air::Functional :BASE;
use Air::Base;
use Air::Component;

class Simple-Greeting does Component {
    has Str $.name = 'Somebody';

    method STYLE {
        Q|p {color:blue}|
    }

    method HTML {
        p "Hello, $.name!"
    }
}
sub simple-greeting(*@a, *%h) { Simple-Greeting.new( |@a, |%h ) }

my $site =
    site :register(Simple-Greeting.new),
        page
            main
                simple-greeting :name<World>;

$site.serve;
