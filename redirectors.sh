#!/bin/bash

LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME-$TIMESTAMP.log"
mkdir -p $LOGS_FOLDER

R="\e[31m"
G="\e[32m"
N="\e[0m"

VALIDATE(){
    if [ $1 -ne 0 ]
    then    
        echo  -e "$2 is ... $R failed $N" | tee -a $LOG_FILE
        exit 1
    else 
        echo -e "$2 is ... $G success $N" | tee -a $LOG_FILE
    fi
}

USAGE(){

    echo "USAGE:: sudo sh redirectors.sh package1 package2 ..."
}

echo "the script started executed at $(date)" &>>$LOG_FILE
USERID=$(id -u)

if [ $USERID -ne 0 ]
then 
    echo "user has no root access please proceed with the root access" &>>$LOG_FILE
    exit 2
fi

if [ $# -eq 0 ]
then 
    USAGE
fi

for package in $@
do
    dnf list installed $package &>>$LOG_FILE
    if [ $? -ne 0 ]
    then 
        echo "$package is not installed now its going to be installed" &>>$LOG_FILE
        dnf install $package -y &>>$LOG_FILE
        VALIDATE $? "INSTALLING $package"
    else 
        echo "$package is already installed...nothing to do" | tee -a $LOG_FILE
    fi    

done
