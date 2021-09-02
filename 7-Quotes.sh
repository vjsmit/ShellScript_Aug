#!/bin/bash

echo *

ls -ld /opt /opt1 &>/tmp/out
echo 'exit status of the ls command= $?'
ls -ld /opt /opt1 &>/tmp/out
echo "exit status of the ls command = $?"

echo "*"
echo '*'

echo -e Hello\\nWorld

echo  "Cost of apple is \$100"
