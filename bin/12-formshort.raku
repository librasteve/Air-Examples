#!/usr/bin/env raku

use Air::Form;

class Contact does Form {
    has Str    $.first-names   is validated(%va<names>);
    has Str    $.last-name     is validated(%va<name>)   is required;
    has Str    $.email         is validated(%va<email>)  is required is email;
    has Str    $.city          is validated(%va<text>);

    has Str    $.captcha       is captcha(:label('Are you human?'));
    has Str    $.captcha-token is hidden;

    method validate-form {
        unless self.captcha-valid {
            self.add-validation-error("Please answer the math question correctly")
        }
    }

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

use Air::Functional :BASE;
use Air::Base;

my &index = &page.assuming(
    title       => 'hÅrc',
    description => 'HTMX, Air, Red, Cro',
    footer      => footer ['Aloft on ', b 'Åir'],
);

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
