#!/bin/bash

action=$1

case $action in
    start)
        echo -e "Starting the service"
        ;;
    stop)
        echo -e "Stopping the service"
        ;;
    *)
        echo "Usage:: $0 Start|Stop"
        echo -e "\t Start -> Starting the service"
        echo -e "\t Stop -> Stopping the service"
esac
