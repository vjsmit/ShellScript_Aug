#!/bin/bash

##Script to setuo both Web and App server

##Color Code
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
BU="\e[1;4m"

LOG=/tmp/stack.log
rm -f /tmp/stack.log

Error() {
    echo -e "\n${R}$1${N}\n"
}

Head() {
    echo -e "\n\t\t>>>>${Y}${BU}$1${N}<<<<\n"
            
}

Print() {
    echo -e "\n\t${G}${BU}$1${N}\n"
}
##Check for root user
USER_ID=$(id -u)
if [ $USER_ID -ne 0 ]; then
    Error "You should be root or sudo user to execute this command"
    exit 1
fi

#Web server setup
Head "Web-Sever Setup"
Print "Installing HTTPD server"

yum install httpd -y &>>$LOG
if [ $? -ne 0 ]; then
    echo "Script is a failure"
    echo "Refer Log file: $LOG"
    exit 2
fi

