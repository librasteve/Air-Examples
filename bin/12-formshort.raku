#!/usr/bin/env raku


# form
use Air::Form;

class Contact does Form {
    has Str    $.first-names is validated(%va<names>);
    has Str    $.last-name   is validated(%va<name>)   is required;
    has Str    $.email       is validated(%va<email>)  is required is email;
    has Str    $.city        is validated(%va<text>);

    method form-routes {
        self.init;

        self.submit: -> Contact $form {
            if $form.is-valid {
                note "Got form data: $form.form-data()";
                self.finish: 'Contact info received!'
            }
            else {
                self.retry: $form
            }
        }
    }
}

my $contact-form = Contact.empty;

# site
use Air::Functional :BASE;
use Air::Base;

class Index is Page {
    has Str $.title       = 'hÅrc';
    has Str $.description = 'HTMX, Air, Red, Cro';

    has Nav $.nav = nav(
        logo    => span( safe '<a href="/">h<b>&Aring;</b>rc</a>' ),
        widgets => [lightdark],
                                 );

    has Footer $.footer   = footer p ['Aloft on ', b 'åir'];
}
sub index(*@a, *%h) { Index.new( |@a, |%h ) };

my $site =
    site :register[$contact-form],
        index
        main
            content [
                h2 'Contact Form';
                $contact-form;
            ];
;

$site.serve;
