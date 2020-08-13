#!/bin/bash

#           DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                   Version 2, December 2004
#
# Copyright (C) 2012 Romain Lespinasse <romain.lespinasse@gmail.com>
#
# Everyone is permitted to copy and distribute verbatim or modified
# copies of this license document, and changing it is allowed as long
# as the name is changed.
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.

function file_exist(){ # is file exist?
    if [ -f $1 ]; then 
        return 0
    else
        return 1
}
function compile_dir(){ # file must exist
    for file in `$5`; do
        if [ -d $1"/"$file ]; then
            if [ $4 == "y" ]; then
                echo "Going into dircetory: "$1"/"$file
                compile_dir $1"/"$file $2 $4 $5 # recurrence
                echo "Leaving into dircetory: "$1"/"$file
            fi
        else
            echo "Compiling $i to object file..."
            #code reuse
            judge "gcc $cflag $file -c -o $2/${file%.*} || exit $?" "g++ $cxxflag $file -c -o $2/${file%.*} || exit $?" 'echo "Warning: Cannot judge the type of $file." >&2'
        fi
    done
} 
function judge(){
    if [ ${i##*.} == "c" ]; then # judge file type, ${i##*.} means suffix name. (C language)
        $1
        $compiler=gcc
        $flag=$cflag
    elif [ ${i##*.} == "cpp" ]; then # C++ language
        $2
        $compiler=g++
        $flag=$cxxflag
    # TODO: more languages
    else
        $3
    fi
}
echo 'Auto-Compile By Liu Tianyou'
if [[ ($# -eq 3) && ($1 == "-auto") ]]; then # auto compile
    for i in $2; do
        echo "Compiling $i to object file..."
        file_exist $i || { echo "Error: $i isn't exist!"; exit 1 }
        #code reuse
        judge "gcc $cflag $i -c -o /tmp/$i.obj || exit $?;" "g++ $cxxflag $i -c -o /tmp/$i.obj || exit $?" 'echo "Error: Cannot judge the type of $i. It means maybe cannot accept linking." >&2; exit 1'
        $objects=$objects" /tmp/"$i".obj" # add a object file to $objects
    done
    echo "Linking everthing together..."
    $compiler $flag $objects -o $3 || exit $? # link
    echo "done."
elif [[ ($# -eq 3) && ($1 == "-dir-compile") ]]; then
    compile_dir $2 $3 "n" 'ls $1' || exit 1
elif [[ ($# -eq 4) && ($1 == "-dir-compile") && ($4 == "-r") ]]; then
    compile_dir $2 $3 "y" 'ls $1' || exit 1
elif [[ ($# -eq 4) && ($1 == "-dir-compile") && (${$4%=*} == "-advance") ]]; then
    compile_dir $2 $3 "n" 'ls $1|grep '${$4##*=} || exit 1
elif [[ ($# -eq 5) && ($1 == "-dir-compile") ]]; then
    compile_dir $2 $3 "y" 'ls $1|grep '${$4##*=} || exit 1
elif [[ ($# -eq 2) && ($1 == "-install") ]]; then # install package
    if command -v apt > /dev/null 2>&1; then
        apt install $2 -y || exit $?
    else
        yum install $2 -y || exit $?
    fi
elif [[ ($# -eq 7) && ($1 == "-compiler") ]]; then
    for i in $2; do
        echo "Compiling $i to object file..." # compile
        $2 $3 $6 $5 $i /tmp/$i.obj || exit $?
        $objects=$objects" /tmp/"$i".obj"
    done
    echo "Linking everthing together..." # link
    $2 $3 $objects $5 $7 || exit $?
    echo "done."
else # help
    echo "Error: Invaild Command Lines." >&2
    cat ../README.md >&2
    exit 1
fi