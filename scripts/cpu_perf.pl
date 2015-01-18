#!/usr/bin/perl
use strict;
my $cpu;
my $Iostat = "/usr/bin/iostat";
my @iostat_output=`$Iostat -c`;
my @cpu=split(/\s+/,$iostat_output[0]);
my $num_cpu=$cpu[$cpu-2];
$num_cpu =~s/\(//;
my @output=split(/\s+/,$iostat_output[3]);
my $tstamp=`date +"%Y-%m-%d %H:%M:%S"`;
chomp($tstamp);
my $HOSTADDR=`/sbin/ifconfig eth0 | egrep "inet addr" | cut -f2 -d ":" | cut -f1 -d " "`;
chomp($HOSTADDR);
print ("HOSTADDR=$HOSTADDR tstamp=$tstamp num_cpu=$num_cpu user=$output[1] nice=$output[2] system=$output[3] iowait=$output[4] steal=$output[5] idle=$output[6]\n");

