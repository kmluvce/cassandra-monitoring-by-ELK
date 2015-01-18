#!/usr/bin/perl
use strict;
my $Nodetool = "/opt/cassandra/bin/nodetool";
my @info=`$Nodetool info`;
my $tstamp=`date +"%Y-%m-%d %H:%M:%S"`;
chomp($tstamp);
my $HOSTADDR=`/sbin/ifconfig eth0 | egrep "inet addr" | cut -f2 -d ":" | cut -f1 -d " "`;
chomp($HOSTADDR);

foreach my $line(@info)
{
  if ($line=~/Heap Memory/)
  {
     my @HM=split(/\s+/,$line);
     my $Heap_Memory_MB=@HM[4];
     my $Heap_Capacity_MB=@HM[6];
     print ("HOSTADDR=$HOSTADDR tstamp=$tstamp Heap_Memory_MB=$Heap_Memory_MB Heap_Capacity_MB=$Heap_Capacity_MB\n");
  }
  if ($line=~/Key Cache/)
  {
     my @KC=split(/\s+/,$line);
     my $Key_Cache_capacity=$KC[7];
     my $Key_Cache_hits=$KC[9];
     my $Key_Cache_request=$KC[11];
     print ("HOSTADDR=$HOSTADDR tstamp=$tstamp Key_Cache_capacity=$Key_Cache_capacity Key_Cache_hits=$Key_Cache_hits Key_Cache_request=$Key_Cache_request\n");
  }
  if ($line=~/Row Cache/)
  {
     my @RC=split(/\s+/,$line);
     my $Row_Cache_capacity=$RC[7];
     my $Row_Cache_hits=$RC[9];
     my $RC_Cache_request=$RC[11];
    print ("HOSTADDR=$HOSTADDR tstamp=$tstamp Row_Cache_capacity=$Row_Cache_capacity Row_Cache_hits=$Row_Cache_hits RC_Cache_request=$RC_Cache_request\n");
  }
}
