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

# make some folders
mkdir /lty-make 2> /dev/null
mkdir /lty-make/download 2> /dev/null
mkdir /lty-make/package 2> /dev/null

function new(){
    if [[ ! -f $1 || `cat $1 | grep "$2" | awk '{print $1}'` == `md5sum $2 | awk '{print $1}'` ]]; then
        touch $1 2> /dev/null # create it
        md5sum $2 >> $1 # write down
        exit 1
    fi
}
function compile_dir(){
    for file in `$5`; do # $5 is "ls -al" etc.
        if [[ -d $1"/"$file && $4 == "y" ]]; then
            echo "Entering into dircetory: "$1"/"$file
            compile_dir $1"/"$file $2 $4 $5 # recurrence
            echo "Leaving into dircetory: "$1"/"$file
        else
            echo "Compiling $i ..."
            judge "gcc $cflag $file -c -o $2/${file%.*}" "g++ $cxxflag $file -c -o $2/${file%.*}" "gpc $pasflag $i -c -o /tmp/$i.obj" "gfortran $forflag $i -c -o /tmp/$i.obj" 'echo "Warning: Cannot judge the type of $file." >&2'
        fi
    done
} 
function judge(){
    # Caution: echo "xxx" | bash can select a pid and fork it.
    # So, Can not edit vars.
    if [ ${i##*.} == "c" ]; then # judge file type, ${i##*.} means suffix name. (C language)
        echo $1 | bash
        $compiler=gcc
        $flag=$cflag
    elif [ ${i##*.} == "cpp" ]; then # C++ language
        echo $2 | bash
        $compiler=g++
        $flag=$cxxflag
    elif [ ${i##*.} == "pas" ]; then # Pascal language
        echo $3 | bash
        $compiler=gpc
        $flag=$pasflag
    elif [[ (${i##*.} == "f90") || (${i##*.} == "f95") || (${i##*.} == "f") || (${i##*.} == "for") ]]; then # Fortran language
        echo $4 | bash
        $compiler=gfortran
        $flag=$forflag
    else
        echo $5 | bash
    fi
}
echo 'Auto-Compile By Liu Tianyou'
if [[ $# -eq 3 && $1 == "auto" ]]; then # auto compile
    for i in $2; do
        echo "Compiling $i to object file..."
        [ -f $i ] || { echo "Error: $i isn't exist!"; exit 1 }
        if new /lty-make/checksum $i; then
            if [ -f /lty-make/objects/$i.obj ]; then
                echo "$i is newest. Skiping..."
                $objects=$objects" /lty-make/objects/"$i".obj" # add a object file to $objects
                continue
            else
                echo "/lty-make/objects/$i.obj is not exist. Compiling..."
            fi
        fi
        judge "gcc $cflag $i -c -o /tmp/$i.obj || exit 1;" "g++ $cxxflag $i -c -o /tmp/$i.obj || exit 1" "gpc $pasflag $i -c -o /tmp/$i.obj || exit 1" "gfortran $forflag $i -c -o /tmp/$i.obj || exit 1" "echo Error: Cannot judge the type of $i. >&2; exit 1"
        $objects="$objects /lty-make/objects/$i.obj"
    done
    echo "Linking everthing together..."
    $compiler $flag $objects -o $3 || exit $? # link
elif [[ $# -eq 3 && $1 == "dir" ]]; then # compile all dir and no options
    compile_dir $2 $3 "n" 'ls $1' || exit 1
elif [[ $# -eq 4 && $1 == "dir" && ($4 == "-r") ]]; then # -f option on
    compile_dir $2 $3 "y" 'ls $1' || exit 1
elif [[ $# -eq 4 && $1 == "dir" && (${$4%=*} == "-advance") ]]; then # -advance option on
    compile_dir $2 $3 "n" 'ls $1|grep '${$4##*=} || exit 1
elif [[ $# -eq 5 && $1 == "dir" ]]; then # all on
    compile_dir $2 $3 "y" 'ls $1|grep '${$4##*=} || exit 1
elif [[ $# -eq 2 && $1 == "install" ]]; then # install package
    if [ $2 == "require" ]; then
        cd /lty-make/download
            wget -O /lty-make/download/m4.tar.gz http://mirrors.kernel.org/gnu/m4/m4-latest.tar.gz
            tar -xzvf /lty-make/download/m4.tar.gz /lty-make/download/m4
            cd m4 # /lty-make/download/m4
                ./configure --prefix=/lty-make/package/m4
                make && make install 
                ln -s /usr/bin/m4 /ltymake/package/m4/bin/m4
        cd ..
            wget -O /lty-make/download/gmp.tar.zst http://mirrors.kernel.org/gnu/gmp/gmp-6.2.0.tar.zst
            tar -I zstd -xvf gmp.tar.zst /lty-make/doenload/gmp
            cd gmp # /lty-make/download/gmp
                ./configure --prefix=/lty-make/package/gmp
                make && make install
                ln -s /usr/bin/gmp /ltymake/package/gmp/bin/gmp
        cd ..
            wget -O /lty-make/download/mpfr.tar.gz http://mirrors.kernel.org/gnu/mpfr/mpfr-4.1.0.tar.gz
            tar -xzvf /lty-make/download/mpfr.tar.gz /lty-make/download/mpfr
            cd mpfr # /lty-make/download/mpfr
                ./configure --prefix=/lty-make/package/mpfr --with-gmp=/lty-make/package/gmp
                make && make install
                ln -s /usr/bin/mpfr /ltymake/package/mpfr/bin/mpfr
        cd ..
            wget -O /lty-make/download/mpc.tar.gz http://mirrors.kernel.org/gnu/mpc/mpc-1.0.1.tar.gz
            tar -xzvf /lty-make/download/mpc.tar.gz /lty-make/download/mpc
            cd mpc # /lty-make/download/mpc
                ./configure --prefix=/lty-make/package/mpc --with-gmp=/lty-make/package/gmp
                make && make install
                ln -s /usr/bin/mpc /ltymake/package/mpc/bin/mpc
        cd ..
    elif [[ $2 == "c" || $2 == "c++" || $2 == "gcc" || $2 == "pascal" || $2 == "fortran" ]]; then
        cd /lty-make/download
            wget -O /lty-make/download/gcc.tar.gz http://mirrors.kernel.org/gnu/gcc/gcc-9.3.0/gcc-9.3.0.tar.gz
            tar -xzvf /lty-make/download/gcc.tar.gz /lty-make/download/gcc
            cd gcc # /lty-make/download/gcc
                ./configure --prefix=/lty-make/package/gcc --enable-languages=c,fortran,pascal
                make && make install
                ln -s /usr/bin/gcc /ltymake/package/gcc/bin/gcc
                ln -s /usr/bin/g++ /ltymake/package/gcc/bin/g++
                ln -s /usr/bin/gfortran /ltymake/package/gcc/bin/gfortran
                ln -s /usr/bin/gpc /ltymake/package/gcc/bin/gpc
        cd ..
    elif [ $2 == "make" ]; then
        cd /lty-make/download
            wget -O /lty-make/download/make.tar.gz http://mirrors.kernel.org/gnu/make/make-4.3.tar.gz
            tar -xzvf /lty-make/download/make.tar.gz /lty-make/download/make
            cd make # /lty-make/download/make
                ./configure --prefix=/lty-make/package/make
                make && make install
                ln -s /usr/bin/make /ltymake/package/make/bin/make
        cd ..
    elif [ $2 == "git" ]; then
        cd /lty-make/download
            wget -O /lty-make/download/git.tar.gz http://mirrors.kernel.org/gnu/git/gnuit-4.9.5.tar.gz
            tar -xzvf /lty-make/download/git.tar.gz /lty-make/download/git
            cd git # /lty-make/download/git
                ./configure --prefix=/lty-make/package/git
                make && make install
                ln -s /usr/bin/git /ltymake/package/git/bin/git
        cd ..
    elif [ $2 == "bash" ]; then
        cd /lty-make/download
            wget -O /lty-make/download/bash.tar.gz http://mirrors.kernel.org/gnu/bash/bash-5.0.tar.gz
            tar -xzvf /lty-make/download/bash.tar.gz /lty-make/download/bash
            cd bash # /lty-make/download/bash
                ./configure --prefix=/lty-make/package/bash
                make && make install
                ln -s /usr/bin/bash /ltymake/package/bash/bin/bash
        cd ..
    elif [ $2 == "python" ]; then
        cd /lty-make/download
            wget -O /lty-make/download/python.tar.gz https://www.python.org/ftp/python/3.9.0/Python-3.9.0rc1.tgz
            tar -xzvf /lty-make/download/python.tar.gz /lty-make/download/python
            cd python # /lty-make/download/python
                ./configure --prefix=/lty-make/package/python
                make && make install
                ln -s /lty-make/package/python/bin/python3 /usr/bin/python3
                ln -s /lty-make/package/python/bin/pip3 /usr/bin/pip3
        cd ..
    fi
    rm -rf /lty-make/download
elif [[ $# -eq 2 && $1 == "remove" ]]; then # install package
    if [ $2 == "require" ]; then
        rm -rf /lty-make/package/m4 /usr/bin/m4
        rm -rf /lty-make/package/m4 /usr/bin/gmp
        rm -rf /lty-make/package/m4 /usr/bin/mpfr
        rm -rf /lty-make/package/m4 /usr/bin/mpc
    elif [[ $2 == "c" || $2 == "c++" || $2 == "gcc" || $2 == "pascal" || $2 == "fortran" ]]; then
        rm -rf /lty-make/package/gcc /usr/bin/gcc
    elif [ $2 == "make" ]; then
        rm -rf /lty-make/package/make /usr/bin/make
    elif [ $2 == "git" ]; then
        rm -rf /lty-make/package/git /usr/bin/git
    elif [ $2 == "bash" ]; then
        rm -rf /lty-make/package/bash /usr/bin/bash
    elif [ $2 == "python" ]; then
        rm -rf  /lty-make/package/python /usr/bin/python3 /usr/bin/pip3
    fi
elif [[ $# -eq 7 && $1 == "compiler" ]]; then # old compile
    for i in $2; do
        echo "Compiling $i to object file..." # compile 
        $2 $3 $6 $5 $i /tmp/$i.obj || exit $?
        $objects="$objects /tmp/$i.obj"
    done
    echo "Linking everthing together..." # link
    $2 $3 $objects $5 $7 || exit $?
    echo "done."
else # help
    echo "Error: Invaild Command Lines." >&2
    cat ../README.md >&2
    exit 1
fi
