#!/usr/bin/perl
use strict;
my $Nodetool = "/opt/cassandra/bin/nodetool";
my @process_output=`$Nodetool tpstats`;
my $tstamp=`date +"%Y-%m-%d %H:%M:%S"`;
chomp($tstamp);
my $HOSTADDR=`/sbin/ifconfig eth0 | egrep "inet addr" | cut -f2 -d ":" | cut -f1 -d " "`;
chomp($HOSTADDR);

foreach my $line1(@process_output)
{
next if ($line1=~/^Pool/);
next if ($line1!~/\w+/);
if ($line1=~/Message type/)
  {
    last;
  }

my @line=split(/\s+/,$line1); 
print ("HOSTADDR=$HOSTADDR tstamp=$tstamp Pool_Name=$line[0] Active=$line[1] Pending=$line[2] Completed=$line[3]  Blocked=$line[4]  Alltime_blocked=$line[5]\n");
}
