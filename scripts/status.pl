#!/usr/bin/perl
use strict;
my $Nodetool = "/opt/cassandra/bin/nodetool";
my $STATUS;
my @status_output=`$Nodetool status`;
my $tstamp=`date +"%Y-%m-%d %H:%M:%S"`;
chomp($tstamp);
my $HOSTADDR=`/sbin/ifconfig eth0 | egrep "inet addr" | cut -f2 -d ":" | cut -f1 -d " "`;
chomp($HOSTADDR);


foreach my $line(@status_output)
{
  if ($line=~/Datacenter:/)
  {
    my @DC=split(/\s+/,$line);
    my $Datacenter=@DC[1];
    
  }
  if ($line=~/\d{1,3}.\d{1,3}.\d{1,3}.\d{1,3}/)
  {

   my @data=split(/\s+/,$line);
   if ($data[0]=~/^U[A-Z]/)
   {
      $STATUS="UP";
   }
   else
   {
      $STATUS="DOWN";
   }
   my $HOST=$data[1];
   my $DATA_VOLUME=$data[2];
   my $UNITS=$data[3];  
   if ($UNITS =~ /KB/)
   {
      $DATA_VOLUME=$DATA_VOLUME/1000;
   }
   my $DATA_PC=$data[5];
   $DATA_PC=~s/%//;
   print("HOSTADDR=$HOSTADDR tstamp=$tstamp STATUS=$STATUS HOST=$HOST DATA_VOLUME=$DATA_VOLUME DATA_PC=$DATA_PC\n");
}
}
