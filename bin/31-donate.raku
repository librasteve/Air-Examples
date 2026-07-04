#!/usr/bin/env raku

use Air::Functional :BASE;
use Air::Base;
use Air::Plugin::Donate;

my $site =
site
    page
        main [
            donate
                :key<MYKEY>,
                :heading('Credit Card and others'),
                :label('Donate via Stripe'),
                :methods[
                    'Credit Card',
                    'Klarna',
                    'Revolut Pay',
                    'SOFORT',
                    'Przelewy24',
                    'Bancontact',
                    'MobilePay',
                    'eps-Überweisung',
                    'iDEAL',
                ],
                :note('This costs us some fees, but works worldwide in all currencies.');
        ]
;

$site.serve;
