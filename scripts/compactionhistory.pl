#!/usr/bin/perl
use strict;
my @history=`/opt/cassandra/bin/nodetool compactionhistory`;
my $tstamp=`date +"%Y-%m-%d %H:%M:%S"`;
chomp($tstamp);
my $HOSTADDR=`/sbin/ifconfig eth0 | egrep "inet addr" | cut -f2 -d ":" | cut -f1 -d " "`;
chomp($HOSTADDR);
foreach my $line(@history)
{
   next if($line=~/(Compaction History:|id)/);
   my @data = split(/\s+/,$line);
   chomp(@data);
   print ("tstamp=$tstamp HOSTADDR=$HOSTADDR id=$data[0] keyspace_name=$data[1] columnfamily_name=$data[2]  compacted_at=$data[3]  bytes_in=$data[4]  bytes_out=$data[5] rows_merged=$data[6]\n");
}
