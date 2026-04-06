#!/usr/bin/env raku

use Air::Functional :BASE;
use Air::Base;

sub common($content) {
    main
        div [
            h3 $content;
        ];
}

#index can be anything eg '/'
my @pages = (
    Page.new(stub => 'home',                           common('home' )),
    Page.new(stub => 'about',                          common('about')),
    Page.new(stub => 'blog',                           common('blog' )),
    Page.new(stub => 'first-post',  parent => 'blog',  common('1st'  )),
    Page.new(stub => 'second-post', parent => 'blog',  common('2nd'  )),
    Page.new(stub => 'team',        parent => 'about', common('team' )),
);

#longhand
#my Nav $nav =
#    nav
#        items => [
#            home        => @pages[0],
#            about       => @pages[1],
#            blog        => @pages[2],
#            first-post  => @pages[3],
#            second-post => @pages[4],
#            team        => @pages[5],
#        ];

my Nav $nav = nav( items => (@pages.map: {.stub => $_}) );
@pages.map: { .nav = $nav };

my $site = Site.new: :@pages;

#some debug
note "\nSitemap:";
.note for $site.sitemap.list;
note "\nSite Tree:";
note $site.tree;
note "\nLookup:";
note $site.sitemap.lookup(<blog second-post>);
note "\nSitemap routes:";
note $site.sitemap.routes;

$site.serve;


