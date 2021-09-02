#!/bin/bash

##Script to setuo both Web and App server

##Check for root user
USER_ID=$(id -u)
if [ $USER_ID -ne 0 ]; then
    echo "You should be root or sudo user to execute this command"
    exit 1
fi

#Web server setup

LOG=/tmp/stack.log
rm -f /tmp/stack.log
yum install httpd -y &>>$LOG
if [ $? -ne 0 ]; then
    echo "Script is a failure"
    echo "Refer Log file: $LOG"
    exit 2
fi

