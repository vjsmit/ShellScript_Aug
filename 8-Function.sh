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
    return 50
}

samplez
echo "Status of the function = $?"

sample_var() {
    af=100
    echo "Value of am is $am"
}

am=200
sample_var
echo "Value of af is $af"

sample_local() {
    local a2=17
    echo "Value of a2 in function: $a2"
}

sample_local
echo "Value of a2 in main program: $a2"