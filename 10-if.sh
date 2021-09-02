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

# if [ "$action" = "start" ]; then 
#     echo "Starting the service"
# elif [ "$action" = "stop" ]; then 
#     echo "Stopping the service"
# else 
#     echo "Usage:: $0 start|stop"
#     echo -e "\t ${R}start${N} -> Start the service"
#     echo -e "\t ${R}stop${N}  -> Stop the service"
#     exit 1
# fi



