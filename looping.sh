#!/bin/bash

R="\e[31m"
G="\e[32m"
N="\e[0m"

VALIDATE(){
    if [ $1 -ne 0 ]
    then    
        echo  -e "$2 is ... $R failed $N"
        exit 1
    else 
        echo -e "$2 is ... $G success $N"
    fi
}

USERID=$(id -u)

if [ $USERID -ne 0 ]
then 
    echo "user has no root access please proceed with the root access"
    exit 2
fi

for package in $@
do
    echo $package



done
