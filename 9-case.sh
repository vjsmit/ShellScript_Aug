#!/bin/bash

action=$1
R="\e[1;31m"
N="\e[0m"
case $action in
    start)
        echo -e "Starting the service"
        ;;
    stop)
        echo -e "Stopping the service"
        ;;
    *)
        echo "Usage:: $0 Start|Stop"
        echo -e "\t ${R}Start${N} -> Starting the service"
        echo -e "\t ${R}Stop${N} -> Stopping the service"
        exit 2
esac
