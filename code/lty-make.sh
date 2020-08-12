#!/bin/bash

# Auto-Compile By Liu Tianyou
# $1 -> compiler
# $2 -> targets
# $3 -> flags
# $4 -> only compile flags
# $5 -> object name
# for example, $0 "g++" "main.cpp hello.cpp good.cpp" "-std=c++11 -O3 -g -p -o" "-c" "foobar.out"
# Cation: Look at the flag "-o" at last

if [[ ($# -ne 5) ]]; then # invaild
    echo 'Auto-Compile By Liu Tianyou'
    echo '$1 -> compiler'
    echo '$2 -> targets'
    echo '$3 -> flags'
    echo '$4 -> only compile flags'
    echo '$5 -> object name'
    echo -e 'for example, '
    echo -e $0
    echo ' "g++" "main.cpp hello.cpp good.cpp" "-std=c++11 -O3 -g -p -o" "-c" "foobar.out"'
    echo 'Cation: Look at the flag "-o" at last!'
    exit 1
fi

$compiler=$1 # init compiler
$targets=$2 # init main target
$flags=$3 # init targets
$only_compile=$4 # init only-compile flag
$name=$5 # init object name

for str in $targets; do # look at targets
    echo "Running command: $compiler $str $flags \"/tmp/\"$str\".o\" $only_compile"
    $compiler $str $flags "/tmp/"$str".o" $only_compile # create temp object file
    if [ $? -ne 0 ]; then exit $?; fi
    $objcets=$objects" /tmp/"$str".o"
done

echo "Running command: $compiler $objects $flag $name"
$compiler $objects $flag $name # link them
echo "Well done. Outputed filename is $name."
exit $?