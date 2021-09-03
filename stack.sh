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
    echo -e "\n\t$1 - "
}

Stat() {
    if [ $? -eq 0 ]; then
        echo -e "${G}SUCCESS${N}"
    else
        echo -e "${G}FAILURE${N}"
        echo -e "Refer the log file for more details -- $LOG"
    fi
}
##Check for root user
USER_ID=$(id -u)
if [ $USER_ID -ne 0 ]; then
    Error "You should be root or sudo user to execute this command"
    exit 1
fi

#Web server setup
Head "Web-Sever Setup"
Print "Install HTTPD server"

yum install httpd -y &>>$LOG
Stat $?

