#!/bin/bash

i=0
while [ $i -lt 60 ]; do
    echo Hello from $i
    sleep 1
    i=$(($i+1))

done