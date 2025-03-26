#!/bin/bash

DISK_USAGE=$(df -hT | grep xfs)
DISK_threshold=5

while IFS= read -r line
do
    USAGE=$(echo $line | grep xfs | awk -F " " '{print $6F}' | cut -d "%" -f2)
    PARTI=$(echo $line | grep xfs | awk -F " " '{print $nF}')
    if [ $USAGE -ge $DISK_threshold ]
    then 
        echo "$PARTI is more than $DISK_threshold,cureent value is $USAGE"
    fi

done <<< $DISK_USAGE
