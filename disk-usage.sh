#!/bin/bash

DISK_USAGE=$(df -hT | grep xfs)
DISK_threshold=5

while IFS= read -r line
do
    echo $line
    
done <<< $DISK_USAGE
