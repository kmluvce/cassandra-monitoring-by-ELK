#!/usr/bin/perl
use strict;
my $Active;
my $Pending;
my $Completed;
my @output;
my $Nodetool = "/opt/cassandra/bin/nodetool";
my @netstats_output=`$Nodetool netstats`;
my $tstamp=`date +"%Y-%m-%d %H:%M:%S"`;
chomp($tstamp);
my $HOSTADDR=`/sbin/ifconfig eth0 | egrep "inet addr" | cut -f2 -d ":" | cut -f1 -d " "`;
chomp($HOSTADDR);

foreach my $line(@netstats_output)
{
   if ($line=~/Commands/)
     {
         @output=split(/\s+/,$line);
         if($output[1]=~/n\/a/)
         {
             $Active=0;
         }
         else 
         {
             $Active=$output[1];
         }
         if($output[2]=~/n\/a/)
         {
             $Pending=0;
         }
         else
         {
             $Pending=$output[2];
         }
         if ($output[3]=~/n\/a/)
         {
             $Completed=0;
         }
         else
         {
             $Completed=$output[3];
         }
         
         print ("HOSTADDR=$HOSTADDR tstamp=$tstamp Pool_Name=Commands Active=$Active Pending=$Pending Completed=$Completed\n");



     }
   if ($line=~/Responses/)
     {
         @output=split(/\s+/,$line);
         if ($output[1]=~/n\/a/)
         {
             $Active=0;
         }
         else
         {
             $Active=$output[1];
         }
         if ($output[2]=~/n\/a/)
         {
             $Pending=0;
         }
         else
         {
             $Pending=$output[2];
         }
         if ($output[3]=~/n\/a/)
         {
             $Completed=0;
         }
         else
         {
             $Completed=$output[3];
         }
         print ("HOSTADDR=$HOSTADDR tstamp=$tstamp Pool_Name=Responses Active=$Active Pending=$Pending Completed=$Completed\n");

     }
} 
