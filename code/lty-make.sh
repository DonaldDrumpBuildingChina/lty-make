#!/bin/bash
echo 'Auto-Compile By Liu Tianyou'
if [[ ($# -eq 3) && ($1 == "-auto") ]]; then # auto compile
    for i in $2; do
        echo "Compiling $i to object file..."
        if [ ${i##*.} == "c" ]; then # judge file type, ${i##*.} means suffix name. (C language)
            gcc $cflag $i -c -o /tmp/$i.obj || exit $?
            $compiler=gcc
            $flag=$cflag
        elif [ ${i##*.} == "cpp" ]; then # C++ language
            g++ $cxxflag $i -c -o /tmp/$i.obj || exit $?
            $compiler=g++
            $flag=$cxxflag
        # TODO: more languages
        else
            echo "Error: Cannot judge the type of $i. It means maybe cannot accept linking." >&2
            exit 1
        fi
        $objects=$objects" /tmp/"$i".obj" # add a object file to $objects
    done
    echo "Linking everthing together..."
    $compiler $flag $objects -o $3 || exit $? # link
    echo "done."
elif [[ ($# -eq 3) && ($1 == "-dir-compile") ]]; then
    for file in `ls $2`; do
        echo "Compiling $i to object file..."
        if [ ${i##*.} == "c" ]; then # C, ${file%.*} means file name(no suffix name)
            gcc $cflag $i -c -o $3/${file%.*} || exit $?
        elif [ ${i##*.} == "cpp" ]; then # C++
            g++ $cxxflag $i -c -o $3/${file%.*} || exit $?
        # TODO: more languages
        else
            echo "Warning: Cannot judge the type of $i." >&2
        fi
    done
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