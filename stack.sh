#!/bin/bash

##Script to setuo both Web and App server

##Color Code
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

Error() {
    echo -e "\n${R}$1${N}\n"
}

Head() {
    echo -e "\n\t\t>>>>${Y}$1${N}<<<<\n"
            
}

##Check for root user
USER_ID=$(id -u)
if [ $USER_ID -ne 0 ]; then
    Error "You should be root or sudo user to execute this command"
    exit 1
fi

#Web server setup
Head "Web-Sever Setup"

LOG=/tmp/stack.log
rm -f /tmp/stack.log
yum install httpd -y &>>$LOG
if [ $? -ne 0 ]; then
    echo "Script is a failure"
    echo "Refer Log file: $LOG"
    exit 2
fi

