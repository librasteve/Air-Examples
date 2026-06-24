#!/usr/bin/env raku

use Air::Functional :BASE;
use Air::Base;
use Air::Plugin::MailForm;

my $contact = Air::Plugin::ContactForm.empty;

my &index = &page.assuming(
    title => 'Contact Us',
    nav => nav(
        widgets => [lightdark],
    ),
);

my $site =
site :register[$contact, LightDark.new],
    index
        main [
            h3 'Contact Us';
            $contact;
        ]
;

$site.serve;
