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
    dnf list installed $package
    if [ $? -ne 0 ]
    then 
        echo "$package is not installed now its going to be installed"
        dnf install $package -y
        VALIDATE $? "INSTALLING $package"
    else 
        echo "$package is already installed...nothing to do"
    fi    

done
