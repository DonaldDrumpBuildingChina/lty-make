#!/bin/bash
function compile_dir(){
    for file in `ls $1`; do
        if [ -d $1"/"$file ]; then
            echo "Going into dircetory: "$1"/"$file
            compile_dir $1"/"$file $2
            echo "Leaving into dircetory: "$1"/"$file
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
        $compiler=gcc
        $flag=$cflag
    # TODO: more languages
    else
        $3
    fi
}
echo 'Auto-Compile By Liu Tianyou'
if [[ ($# -eq 3) && ($1 == "-auto") ]]; then # auto compile
    for i in $2; do
        echo "Compiling $i to object file..."
        #code reuse
        judge "gcc $cflag $i -c -o /tmp/$i.obj || exit $?;" "g++ $cxxflag $i -c -o /tmp/$i.obj || exit $?" 'echo "Error: Cannot judge the type of $i. It means maybe cannot accept linking." >&2; exit 1'
        $objects=$objects" /tmp/"$i".obj" # add a object file to $objects
    done
    echo "Linking everthing together..."
    $compiler $flag $objects -o $3 || exit $? # link
    echo "done."
elif [[ ($# -eq 3) && ($1 == "-dir-compile") ]]; then
    compile_dir $2 $3
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