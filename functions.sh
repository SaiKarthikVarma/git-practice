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

dnf list installed git 


if [ $? -ne 0 ]
then 
    echo "git is not installed now its going to be installed"
    dnf install git -y
    VALIDATE $? "INSTALLING GIT"
else 
    echo " git is already installed"
fi

dnf list installed mysql 

if [ $? -ne 0 ]
then 
    echo "mysql is not installed now its going to be installed"
    dnf install mysql -y
    VALIDATE $? "INSTALLING MYSQL"
else
    echo "mysql is already installed"
fi