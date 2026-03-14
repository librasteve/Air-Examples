#!/usr/bin/env raku

use Air::Functional :BASE;
use Air::Base;

my @pages = (
    Page.new(stub => ''),
    Page.new(stub => 'about'),
    Page.new(stub => 'blog'),
    Page.new(stub => 'first-post', parent-stub => 'blog'),
    Page.new(stub => 'second-post', parent-stub => 'blog'),
    Page.new(stub => 'team', parent-stub => 'about'),
);


my $site = Site.new: :@pages;

note "\nSitemap:";
.note for $site.sitemap.list;

note $site.tree;

note "\nLookup:";
note $site.sitemap.lookup('/blog/second-post');

$site.serve;


