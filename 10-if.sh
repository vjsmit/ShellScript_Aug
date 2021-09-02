#!/bin/bash

R="\e[33m"
N="\e[0m"

action=$1

if ["$action"="start"]; then
    echo "Starting the service"
elif["$action"="stop"]; then
    echo "Stoping the service"
else
    echo "Usage:: $0 start|stop"
    echo "${R}start${N} ->starting the service"
    echo "${R}stop${N} -> stoping the service"
fi
