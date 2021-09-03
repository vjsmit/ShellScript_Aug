#!/bin/bash

##Script to setuo both Web and App server

##Color Code
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
W="0x78"

Error() {
    echo -e "\n${R}$1${N}\n"
}

##Check for root user
USER_ID=$(id -u)
if [ $USER_ID -ne 0 ]; then
    Error "${W}You should be root or sudo user to execute this command"
    exit 5
fi

#Web server setup
echo -e "\t\t\t\t\t>>>>>>>>>>>${Y}Web Sever Setup${N}<<<<<<<<<<<<<<<<<<"
LOG=/tmp/stack.log
rm -f /tmp/stack.log
yum install httpd -y &>>$LOG
if [ $? -ne 0 ]; then
    echo "Script is a failure"
    echo "Refer Log file: $LOG"
    exit 2
fi

