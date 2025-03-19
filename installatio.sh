#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0]
then 
    echo "user has no root access please proceed with the root access"
    exit 2
fi

dnf list installed git 

if [ $? -ne 0]
then 
    echo "git is not installed now its going to be installed"
    dnf install git -y
    if [ $? -ne 0]
    then 
        echo "git is not installed..please check"
    else
        echo "git installation successfull"
    fi
fi

dnf list installed mysql 

if [ $? -ne 0]
then 
    echo "mysql is not installed now its going to be installed"
    dnf install git -y
    if [ $? -ne 0]
    then 
        echo "mysql is not installed..please check"
    else
        echo "mysql installation successfull"
    fi
fi