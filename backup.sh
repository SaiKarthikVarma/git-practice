#!/bin/bash

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} #if $3 is empty then if will take 14 as default
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)

USAGE(){
    echo "USAGE:: sh backup.sh <source> <destination> <days(optional)>"
}

#check the source and destination are provided

if [ $# -lt 2 ]
then 
    USAGE
fi

if [ ! -d $SOURCE_DIR ]
then    
    echo "$SOURCE_DIR doesnt exist..please check.."
fi

if [ ! -d $DEST_DIR ]
then    
    echo "$DEST_DIR doesnt exist..please check.."
fi

FILES=$(find ${SOURCE_DIR} -name "*.log" -mtime +14)

echo "FILES:: $FILES"

if [ ! -z $FILES ] #-z is for to know true if the files are none and ! makes opposite  so if files are not empty then files are found is displayed
then 
    echo "Files are found"
    ZIP_FILE="$DEST_DIR/app-logs-$TIMESTAMP.zip"
    find ${SOURCE_DIR} -name "*.log" -mtime +14 | zip "$ZIP_FILE" -@

    if [ -f $ZIP_FILE ]
    then
        echo "Successfully zipped files older than $DAYS"

        #remove the files after zipping
        while IFS= read -r file
        do
            echo "deleting file : $file"
            rm -rf $file
        done <<< $FILES

    else
        echo "Zipping the files is failed"
        exit 1
    fi

else 
    echo "no files older than $DAYS"
fi