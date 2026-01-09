#!/usr/bin/env raku

#this example inspired by https://lit.dev/playground/
#untested

use Air::Functional :BASE;
use Air::Base;
use Air::Component;

class Simple-Greeting does Component {
    has Str $.name = 'Somebody';

    ## put head JS / CSS methods here

    method STYLE {
        Q|p {color:blue}|
    }

    method SCRIPT {
        Q|
            import {html, css, LitElement} from 'lit';
            import {customElement, property} from 'lit/decorators.js';

            @customElement('simple-greeting')
            export class SimpleGreeting extends LitElement {
              static styles = css`p { color: blue }`;

              @property()
              name = 'Somebody';

              render() {
                return html`<p>Hello, ${this.name}!</p>`;
              }
            }
        |;
    }

    method HTML {
        '<simple-greeting name="' ~ $!name ~ '"></simple-greeting>'
    }
}
sub simple-greeting(*@a, *%h) { Simple-Greeting.new( |@a, |%h ) }

my $site =
    site :register(Simple-Greeting.new),
        page
            main
                simple-greeting :name<World>;

$site.serve;
