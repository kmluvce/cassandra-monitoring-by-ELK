#!/usr/bin/perl
use strict;
my $Free = "/usr/bin/free";
my @mem_output=`$Free -m`;
my @keys=split(/\s+/,$mem_output[0]);
my @value1=split(/\s+/,$mem_output[1]);
my @value2=split(/\s+/,$mem_output[3]);
my $tstamp=`date +"%Y-%m-%d %H:%M:%S"`;
chomp($tstamp);
my $HOSTADDR=`/sbin/ifconfig eth0 | egrep "inet addr" | cut -f2 -d ":" | cut -f1 -d " "`;
chomp($HOSTADDR);

print ("HOSTADDR=$HOSTADDR tstamp=$tstamp Type=Swap total=$value2[1] used=$value2[2] free=$value2[3]\n");
print ("HOSTADDR=$HOSTADDR tstamp=$tstamp Type=Memory total=$value1[1] used=$value1[2] free=$value1[3]\n"); 
