#!/usr/bin/env raku

use Air::Functional :BASE;
use Air::Base;
use Air::Form;
use Air::Plugin::MailForm;

class SignupForm is Air::Plugin::MailForm {
    has Str $.name  is validated(%va<names>) is required;
    has Str $.nick;
    has Str $.email is validated(%va<email>) is email is required;

    method do-form-attrs {
        self.form-attrs: {:submit-button-text('Register Interest')}
    }

    method validate-form {
        self.add-validation-error("Nick must be a single word")
            if $!nick && $!nick.trim.contains(/ \s /);
    }

    method mail-body {
        "Name:  { $.name  }\n" ~
        "Nick:  { $.nick || '(not provided)' }\n" ~
        "Email: { $.email }"
    }
}

my $signup = SignupForm.empty;

my &index = &page.assuming(
    title => 'Sign Up',
    nav => nav(
        widgets => [lightdark],
    ),
);

my $site =
site :register[$signup, LightDark.new],
    index
        main [
            h3 'Register Interest';
            $signup;
        ]
;

$site.serve;
