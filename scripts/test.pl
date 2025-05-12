#!/usr/bin/env perl
use 5.020;
use utf8;
use warnings;
use autodie;
use feature qw/signatures postderef/;
no warnings qw/experimental::postderef/;

use Mojo::UserAgent;
use Mojo::Util;
use Mojo::File;
use DDP;

use Env qw/DEEPDANBOORU_ENDPOINT/;
die unless $DEEPDANBOORU_ENDPOINT;

my $path = $ARGV[0];
utf8::decode($path);

my $ua = Mojo::UserAgent->new;
my $image = Mojo::File::path($path)->slurp;
my $bytes = Mojo::Util::b64_encode $image;
my $resp = $ua->post(
    "$DEEPDANBOORU_ENDPOINT/tag", json => {
        image => $bytes
    }
)->result;
my $json = $resp->json;
p $json;
