#!/bin/bash

VALIDATE(){
    if [ $1 -ne 0 ]
    then    
        echo " $2 is ...failed"
        exit 1
    else 
        echo " $2 is ...success"
    fi
}

USERID=$(id -u)

if [ $USERID -ne 0 ]
then 
    echo "user has no root access please proceed with the root access"
    exit 2
fi

dnf list installed git 

VALIDATE $?

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