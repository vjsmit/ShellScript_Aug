#!/bin/bash

echo *

ls -ld /opt /opt1 &>/tmp/out
echo 'exit status of the ls command= $?'
ls -ld /opt /opt1 &>/tmp/out
echo "exit status of the ls command = $?"
