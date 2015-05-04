#!/usr/bin/env perl
#
use strict;
use v5.10;
use Cwd qw(cwd abs_path);
use Data::Dumper;
use File::Basename;
use File::Spec::Functions;

our $appName = getCurrFolder();

system(('rm','-rf','./db'));
system(('rm','-rf','./dbd'));
system(('rm','-rf','./configure'));
system(('rm','-rf','./documentation'));
system(('rm','-rf','./iocBoot'));
system(('rm','-rf','./bin'));
system(('rm','-rf','./Makefile'));
system(('rm','-rf','./' . $appName . 'App'));
system(('rm','-rf','./' . $appName . 'Sup'));
system('cp ./install/* .');

sub getCurrFolder {
    my @s = split(/\//, cwd());
    my $output = undef;
    $output = $s[-1] if ($s[-1] ne "");
    $output = $s[-2] if ($s[-1] eq "");
    return $output if defined $output || die "what the shit?";
}

