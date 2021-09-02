samplex() {
    echo Hello
    echo Bye
}


samplex


sampley() {
    echo First Argument = $1
    echo Second Argument = $2
}

sampley 18 10


samplez() {
    echo Hello
    return
}

samplez
echo "Status of the function = $?"