#!/usr/bin/perl
#use strict;
my $Nodetool = "/opt/cassandra/bin/nodetool";
my @output=`$Nodetool cfstats`;
my $Read_Latency_ms;
my $HOSTADDR=`/sbin/ifconfig eth0 | egrep "inet addr" | cut -f2 -d ":" | cut -f1 -d " "`;
chomp($HOSTADDR);
my $tstamp=`date +"%Y-%m-%d %H:%M:%S"`;
chomp($tstamp);
foreach my $line1(@output)
{
  next if($line1 !~ /(Keyspace:|Read Count:|Read Latency:|Write Count:|Write Latency:|Pending Tasks:)/);
  push(@filter_output,$line1);
}

foreach my $line(@filter_output)
{
   if ($line=~/Keyspace:/)
   {
      @KS=split(/\s+/,$line);
      $Keyspace=$KS[1];
      next;
   }
   if ($line=~/Read Count:/)
   {
      @RC=split(/:/,$line);
      $Read_Count= $RC[1];
      next;
   }
   if ($line=~/Read Latency:/)
   {
     @RL=split(/:/,$line);
     if ($RL[1]=~/NaN/)
     {
       $Read_Latency_ms=0;
     }
     else
     {
       $Read_Latency_ms=$RL[1];
     }
     next;
   }
   if ($line=~/Write Count:/)
   {
     @WC=split(/:/,$line);
     $Write_Count=$WC[1];
     next;
   }
   if ($line=~/Write Latency:/)
   {
      @WL=split(/:/,$line);
      if ($WL[1]=~/NaN/)
      {
        $Write_Latency_ms=0;
     }
     else
     {
       $Write_Latency_ms=$RL[1];
     }
     next;
   }
  if ($line=~/Pending Tasks:/)
  {
     @PT=split(/:/,$line);
     $Pending_Tasks=$PT[1];
     #next;
  }
  chomp($Keyspace);
  chomp($Read_Count);
  chomp($Read_Latency_ms);
  $Read_Latency_ms=~s/ms\.//g;
  chomp($Write_Count);
  chomp($Write_Latency_ms);
  $Write_Latency_ms=~s/ms\.//g;
  chomp($Pending_Tasks);
  $Keyspace=~s/\s+//g;
  $Read_Count=~s/\s+//g;
  $Read_Latency_ms=~s/\s+//g;
  $Write_Count=~s/\s+//g;
  $Write_Latency_ms=~s/\s+//g;
  $Pending_Tasks=~s/\s+//g;
 # next if($line !~ /(Keyspace:|Read Count:|Read Latency:|Write Count:|Write Latency:|Pending Tasks:|Table:)/);
print ("HOSTADDR=$HOSTADDR tstamp=$tstamp Keyspace=$Keyspace Read_Count=$Read_Count Read_Latency_ms=$Read_Latency_ms Write_Count=$Write_Count Write_Latency_ms=$Write_Latency_ms Pending_Tasks=$Pending_Tasks\n");
}
