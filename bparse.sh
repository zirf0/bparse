#!/bin/bash

#
# Simple example bash daemon for log parsing
#

# variables
#. /home/ubuntu/bash-daemon/bparse

# Requires inotify-tools

#Check existance... (проверить переменные)

function main()
{
$INOTIFYWAIT -e modify $LOGFILE -m  | while read event
do

if echo $event | grep -q MODIFY;
then service=$(tail -n 10 $LOGFILE | grep  "$SEARCHSTR"  |  awk '{print $5}' | uniq )
	 echo Service original name: $service
	 service=${service%%$DELIM*} 
    	 echo Service parced name: $service
	 #No check here!
	 echo $SUDO $RUNC -HUP $(pidof $service)
  else 
	 echo "Something went wrong!" 
fi

done
}
echo "Running ..."
main &
