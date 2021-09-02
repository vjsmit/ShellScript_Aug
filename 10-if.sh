#!/bin/bash

R="\e[33m"
N="\e[0m"

action=$1

if [ "$action" = "start" ]; then
    echo "Starting the service"
elif [ "$action" ="stop" ]; then
    echo "Stoping the service"
else
    echo "Usage:: $0 start|stop"
    echo -e "${R}start${N} ->starting the service"
    echo -e "${R}stop${N} -> stoping the service"
    exit 1
fi


ls -ld /opt /opt1 &>/dev/null

if ["$?" = 0]; then
    echo Success
else
    echo Failure
fi



