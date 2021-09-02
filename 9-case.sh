#!/bin/bash

action=$1

case $action in
    start)
        echo -e "Starting the service"
        ;;
    stop)
        echo -e "Stopping the service"
        ;;
esac
