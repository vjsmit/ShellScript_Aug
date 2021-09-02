#!/bin/bash

##Script to setuo both Web and App server

#Web server setup

LOG=/tmp/stack.log
rm -f /tmp/stack.log
yum install httpd -y &>>$LOG
if [ $? -ne 0 ]; then
    echo "Script is a failure"
    echo "Refer Log file: $LOG"
    exit 1
fi

