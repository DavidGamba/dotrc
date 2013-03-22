#!/usr/bin/perl -w
use strict;
use Getopt::Long;
use Data::Dumper;
use Pod::Usage qw(pod2usage);

GetOptions(
    'help|?' => sub{ pod2usage(-verbose => 1) },
    'man'    => sub{ pod2usage(-verbose => 3) },
);
