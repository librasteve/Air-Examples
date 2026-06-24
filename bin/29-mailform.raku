#!/usr/bin/env raku

use Air::Functional :BASE;
use Air::Base;
use Air::Plugin::MailForm;

my &index = &page.assuming(
    title => 'Contact Us',
    nav => nav(
        widgets => [lightdark],
    ),
);

my $site =
site :register[$mail-form, LightDark.new],
    index
        main [
            h3 'Contact Us';
            $mail-form;
        ]
;

$site.serve;
