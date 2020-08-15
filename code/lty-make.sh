#!/bin/bash

######################################################################
#           DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE              #
#                   Version 2, December 2004                         #
#                                                                    #
# Copyright (C) 2012 Romain Lespinasse <romain.lespinasse@gmail.com> #
#                                                                    #
# Everyone is permitted to copy and distribute verbatim or modified  #
# copies of this license document, and changing it is allowed as long#
# as the name is changed.                                            #
#                                                                    #
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE             #
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION  #
#                                                                    #
#  0. You just DO WHAT THE FUCK YOU WANT TO.                         #
######################################################################

# Standrand ASCII keyboard
# ┌───┐   ┌───┬───┬───┬───┐ ┌───┬───┬───┬───┐ ┌───┬───┬───┬───┐ ┌───┬───┬───┐
# │Esc│   │ F1│ F2│ F3│ F4│ │ F5│ F6│ F7│ F8│ │ F9│F10│F11│F12│ │P/S│S L│P/B│  ┌┐    ┌┐    ┌┐
# └───┘   └───┴───┴───┴───┘ └───┴───┴───┴───┘ └───┴───┴───┴───┘ └───┴───┴───┘  └┘    └┘    └┘
# ┌───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───────┐ ┌───┬───┬───┐ ┌───┬───┬───┬───┐
# │~ `│! 1│@ 2│# 3│$ 4│% 5│^ 6│& 7│* 8│( 9│) 0│_ -│+ =│ BacSp │ │Ins│Hom│PUp│ │N L│ / │ * │ - │
# ├───┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─────┤ ├───┼───┼───┤ ├───┼───┼───┼───┤
# │ Tab │ Q │ W │ E │ R │ T │ Y │ U │ I │ O │ P │{ [│} ]│ | \ │ │Del│End│PDn│ │ 7 │ 8 │ 9 │   │
# ├─────┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴─────┤ └───┴───┴───┘ ├───┼───┼───┤ + │
# │ Caps │ A │ S │ D │ F │ G │ H │ J │ K │ L │: ;│" '│ Enter  │               │ 4 │ 5 │ 6 │   │
# ├──────┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴────────┤     ┌───┐     ├───┼───┼───┼───┤
# │ Shift  │ Z │ X │ C │ V │ B │ N │ M │< ,│> .│? /│  Shift   │     │ ↑ │     │ 1 │ 2 │ 3 │   │
# ├─────┬──┴─┬─┴──┬┴───┴───┴───┴───┴───┴──┬┴───┼───┴┬────┬────┤ ┌───┼───┼───┐ ├───┴───┼───┤ E││
# │ Ctrl│    │Alt │         Space         │ Alt│    │    │Ctrl│ │ ← │ ↓ │ → │ │   0   │ . │←─┘│
# └─────┴────┴────┴───────────────────────┴────┴────┴────┴────┘ └───┴───┴───┘ └───────┴───┴───┘
# So, don't press any keys wrong!
# And FUCK you, "dear" BUGS!

# echo massage
echo 'Auto-Compile By Liu Tianyou'

# check root user
if [[ $EUID -ne 0 ]]; then
    echo "Using this scipt's user is NOT root. Did you forget using \"sudo\"?"
    exit 1
fi

# make some folders
mkdir /lty-make 2> /dev/null
mkdir /lty-make/download 2> /dev/null
mkdir /lty-make/package 2> /dev/null

# documents
function Help(){
    echo "Error: Invaild Command Lines." > &2
    cat ../README.md > &2
    exit 1
}

# Is it new file?
function new(){
    if [[ ! -f $1 || `cat $1 | grep "$2" | awk '{print $1}'` == `md5sum $2 | awk '{print $1}'` ]]; then
        touch $1 2> /dev/null # create it
        md5sum $2 >> $1 # write down
        exit 1
    fi
}

# Compile all folder
function compile_dir(){
    for file in `echo $5 | bash`; do # $5 is "ls -al" etc.
        if [[ -d $1"/"$file && $4 == "y" ]]; then
            echo "Entering into dircetory: $1/$file" # befor all recurrenced
            compile_dir $1"/"$file $2 $4 $5 # recurrence
            echo "Leaving into dircetory: $1/$file" # after all recurrenced
        else
            echo "Compiling $i ..."
            judge "gcc $cflag $file -c -o $2/${file%.*}" \ # use gcc to compile C source code
            "g++ $cxxflag $file -c -o $2/${file%.*}" \ # use g++ to compile C++ source code
            "gpc $pasflag $i -c -o /tmp/$i.obj" \ # use gpc (GNU Pascal Compiler) to compile Pascal source code
            "gfortran $forflag $i -c -o /tmp/$i.obj" \ # use gfortran to compile Fortran source code
            "gcj $javaflag $i -c -o /tmp/$i.obj || exit 1" \ # use gcj to compile java source code
            'echo "Warning: Cannot judge the type of $file." >&2' # cannot understand the suffix name
        fi
    done
} 

# Compile signal file and it is universally
function judge(){
    # Caution: echo "xxx" | bash can select a pid and fork it.
    # So, Can not edit vars.
    if [[ ${i##*.} == "c" ]]; then # judge file type, ${i##*.} means suffix name. (C language)
        echo $1 | bash
        $compiler=gcc
        $flag=$cflag
    elif [[ ${i##*.} == "cpp" ]]; then # C++ language
        echo $2 | bash
        $compiler=g++
        $flag=$cxxflag
    elif [[ ${i##*.} == "pas" ]]; then # Pascal language
        echo $3 | bash
        $compiler=gpc
        $flag=$pasflag
    elif [[ (${i##*.} == "f90") || (${i##*.} == "f95") || (${i##*.} == "f") || (${i##*.} == "for") ]]; then # Fortran language
        echo $4 | bash
        $compiler=gfortran
        $flag=$forflag
    elif [[ ${i##*.} == "java" ]]; then # Java language
        echo $5 | bash
        $compiler=gcj
        $flag=$javaflag
    else
        echo $6 | bash
    fi
}

# Let's see the command lines!
if [[ $# -eq 3 && $1 == "auto" ]]; then # auto compile
    for i in $2; do
        echo "Compiling $i to object file..."
        [[ -f $i ]] || { echo "Error: $i isn't exist!"; exit 1 }
        if new /lty-make/checksum $i; then
            if [[ -f /lty-make/objects/$i.obj ]]; then
                echo "$i is newest. Skiping..."
                $objects=$objects" /lty-make/objects/"$i".obj" # add a object file to $objects
                continue
            else
                echo "/lty-make/objects/$i.obj is not exist. Compiling..."
            fi
        fi
        judge "gcc $cflag $i -c -o /tmp/$i.obj || exit 1;" \ # use gcc to compile C source code
        "g++ $cxxflag $i -c -o /tmp/$i.obj || exit 1" \ # use g++ to compile C++ source code
        "gpc $pasflag $i -c -o /tmp/$i.obj || exit 1" \ # use gpc (GNU Pascal Compiler) to compile Pascal source code
        "gfortran $forflag $i -c -o /tmp/$i.obj || exit 1" \ # use gfortran to compile Fortran source code
        "gcj $javaflag $i -c -o /tmp/$i.obj || exit 1" \ # use gcj to compile java source code
        "echo Error: Cannot judge the type of $i. >&2; exit 1" # cannot understand the suffix name
        $objects="$objects /lty-make/objects/$i.obj"
    done
    echo "Linking everthing together..."
    $compiler $flag $objects -o $3 || exit $? # link
elif [[ $1 == "dir" ]]; then # good code!
    elif [[ $# -eq 3 ]]; then # compile all dir and no options
        compile_dir $2 $3 "n" 'ls $1' || exit 1
    elif [[ $# -eq 4 && ($4 == "-r") ]]; then # -f option on
        compile_dir $2 $3 "y" 'ls $1' || exit 1
    elif [[ $# -eq 4 && (${$4%=*} == "-advance") ]]; then # -advance option on
        compile_dir $2 $3 "n" 'ls $1|grep '${$4##*=} || exit 1
    elif [[ $# -eq 5 ]]; then # all on
        compile_dir $2 $3 "y" 'ls $1|grep '${$4##*=} || exit 1
    else
        Help || exit $? # do this if status will be changed
    fi
elif [[ $# -eq 3 && $1 == "set" ]]; then
    echo "export $2=$3" > /etc/profile
    source /etc/profile
elif [[ $# -eq 2 && $1 == "install" ]]; then # install package
    cd /lty-make/download 
    if [[ $2 == "require" ]]; then
        # Compiling package m4
            # get source code online
            wget -O /lty-make/download/m4.tar.gz http://mirrors.kernel.org/gnu/m4/m4-latest.tar.gz
            # tar it
            tar -xzvf /lty-make/download/m4.tar.gz /lty-make/download/m4
            cd m4 # /lty-make/download/m4
                # configure it and create Makefile
                ./configure --prefix=/lty-make/package/m4
                # make it
                make && make install 
                # create soft linker
                ln -s /usr/bin/m4 /lty-make/package/m4/bin/m4
        cd ..
        # Compiling package gmp
            # get source code online
            wget -O /lty-make/download/gmp.tar.zst http://mirrors.kernel.org/gnu/gmp/gmp-6.2.0.tar.zst
            # tar it
            tar -I zstd -xvf gmp.tar.zst /lty-make/doenload/gmp
            cd gmp # /lty-make/download/gmp
                # configure it and create Makefile
                ./configure --prefix=/lty-make/package/gmp
                # make it
                make && make install
                # create soft linker
                ln -s /usr/bin/gmp /lty-make/package/gmp/bin/gmp
        cd ..
        # Compiling package mpfr
            # get source code online
            wget -O /lty-make/download/mpfr.tar.gz http://mirrors.kernel.org/gnu/mpfr/mpfr-4.1.0.tar.gz
            # tar it
            tar -xzvf /lty-make/download/mpfr.tar.gz /lty-make/download/mpfr
            cd mpfr # /lty-make/download/mpfr
                # configure it and create Makefile
                ./configure --prefix=/lty-make/package/mpfr --with-gmp=/lty-make/package/gmp
                # make it
                make && make install
                # create soft linker
                ln -s /usr/bin/mpfr /lty-make/package/mpfr/bin/mpfr
        cd ..
        # Compiling package mpc
            # get source code online
            wget -O /lty-make/download/mpc.tar.gz http://mirrors.kernel.org/gnu/mpc/mpc-1.0.1.tar.gz
            # tar it
            tar -xzvf /lty-make/download/mpc.tar.gz /lty-make/download/mpc
            cd mpc # /lty-make/download/mpc
                # configure it and create Makefile
                ./configure --prefix=/lty-make/package/mpc --with-gmp=/lty-make/package/gmp
                # make it
                make && make install
                # create soft linker
                ln -s /usr/bin/mpc /lty-make/package/mpc/bin/mpc
        cd ..
        # Compiling package apr
            # get source code online
            wget -O /lty-make/download/apr.tar.gz http://archive.apache.org/dist/apr/apr-1.4.5.tar.gz
            # tar it
            tar -xzvf /lty-make/download/apr.tar.gz /lty-make/download/apr
            cd apr # /lty-make/download/apr
                # configure it and create Makefile
                ./configure --prefix=/lty-make/package/apr
                # make it
                make && make install
                # create soft linker
                ln -s /usr/bin/apr /lty-make/package/apr/bin/apr
        cd ..
        # Compiling package apr-utill
            # get source code online
            wget -O /lty-make/download/apr-utill.tar.gz http://archive.apache.org/dist/apr/apr-util-1.3.12.tar.gz
            # tar it
            tar -xzvf /lty-make/download/apr-utill.tar.gz /lty-make/download/apr-utill
            cd apr-utill # /lty-make/download/apr-utill
                # configure it and create Makefile
                ./configure --prefix=/lty-make/package/apr-utill
                # make it
                make && make install
                # create soft linker
                ln -s /usr/bin/apr-utill /lty-make/package/apr/bin/apr-utill
        cd ..
        # Compiling package pcre
            # get source code online
            wget -O /lty-make/download/pcre.zip http://jaist.dl.sourceforge.net/project/pcre/pcre/8.10/pcre-8.10.zip 
            # unzip it 
            unzip /lty-make/download/pcre.zip -d /lty-make/download/pcre
            cd pcre # /lty-make/download/pcre
                # configure it and create Makefile
                ./configure --prefix=/lty-make/package/pcre
                # make it
                make && make install
                # create soft linker
                ln -s /usr/bin/pcre /lty-make/package/apr/bin/pcre
        cd ..
        # Compiling package boost
            # get source code online
            wget -O /lty-make/download/boost.tar.gz http://www.sourceforge.net/projects/boost/files/boost/1.59.0/boost_1_59_0.tar.gz
            # tar it 
            tar -xzvf /lty-make/download/boost.tar.gz /lty-make/download/boost
            cd boost # /lty-make/download/boost
                # configure it and create Makefile
                ./configure --prefix=/lty-make/package/boost
                # make it
                make && make install
                # create soft linker
                ln -s /usr/bin/boost /lty-make/package/apr/bin/boost
    elif [[ $2 == "mysql" ]]; then # Compiling package mysql
        # get source code online
        wget -O /lty-make/download/mysql.tar.gz https://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-5.7.24.tar.gz
        # tar it 
        tar -xzvf /lty-make/download/mysql.tar.gz /lty-make/download/mysql
        cd mysql # /lty-make/download/mysql
            # configure it and create Makefile
            cmake -DCMAKE_INSTALL_PREFIX=/lty-make/package/mysql \ # install directory
                -DWITH_BOOST=/lty-make/package/boost \ # with boost library
                -DMYSQL_UNIX_ADDR=/lty-make/package/mysql/tmp/mysql.sock \ # socket file
                -DMYSQL_DATADIR=/lty-make/package/mysql/data \ # data directory
                -DDEFAULT_CHARSET=utf8mb4 \ # charset
                -DDEFAULT_COLLATION=utf8mb4_general_ci \ # collation
                -DWITH_EXTRA_CHARSETS=all \ # with all charsets
                -DWITH_MYISAM_STORAGE_ENGINE=1 \ # with myisam storage engine
                -DWITH_INNOBASE_STORAGE_ENGINE=1 \ # with innobase storage engine
                -DWITH_MEMORY_STORAGE_ENGINE=1 \ # with memory storage engine
                -DWITH_READLINE=1 \ # readline
                -DWITH_INNODB_MEMCACHED=1 \ # memcached
                -DWITH_DEBUG=OFF \ # debug off
                -DWITH_ZLIB=bundled \ # zlib
                -DENABLED_LOCAL_INFILE=1 \ # enable local infile
                -DENABLED_PROFILING=ON \ # enable progiling
                -DMYSQL_MAINTAINER_MODE=OFF \ # off maintainer mode
                -DMYSQL_TCP_PORT=3306 # port
            # make it
            make && make install
            # create soft linker
            ln -s /usr/bin/mysql /lty-make/package/mysql/bin/mysql
    elif [[ $2 == "php" ]]; then # Compiling package php
        # get source code online
        wget -O /lty-make/download/php.tar.gz http://php.net/distributions/php-7.4.0.tar.gz
        # tar it 
        tar -xzvf /lty-make/download/php.tar.gz /lty-make/download/php
        cd php # /lty-make/download/php
            # add php user group
            groupadd php
            # add php user to php group
            useradd -g php php
            # configure it and create Makefile
            ./configure \ 
                --prefix=/lty-make/package/php \ # install directory
                --with-config-file-path=/lty-make/package/php/config \ # config file path
                --with-fpm-user=php \ # php user
                --with-fpm-group=php \ # php group
                --with-curl \ # curl module
                --with-freetype-dir \ # free-type dir module
                --enable-gd \ # gd module
                --with-gettext \  # get-text module
                --with-iconv-dir \ # iconv-dir module
                --with-kerberos \ # kerberos module
                --with-libdir=lib64 \ # x64 lib
                --with-libxml-dir \ # libxml-dir module
                --with-mysqli \ # mysqli module
                --with-openssl \ # openssl module
                --with-pcre-regex \ # pcre-regex module
                --with-pdo-mysql \ # pdo-mysql module
                --with-pdo-sqlite \ # pdo-sqlite module
                --with-pear \ # pear module
                --with-png-dir \ # png-dir module
                --with-jpeg-dir \ # jpeg-dir module
                --with-xmlrpc \ # xmlrpc module
                --with-xsl \ #xsl module
                --with-zlib \ # zlib 
                --with-bz2 \ # bz2
                --with-mhash \ # mhash module
                --enable-fpm \ # php-fpm
                --enable-bcmath \ # bcmath module
                --enable-libxml \ # libxml module
                --enable-inline-optimization \ # inline-optimization module
                --enable-mbregex \ # mbregex module
                --enable-mbstring \ # mbstring
                --enable-opcache \ # opcache module
                --enable-pcntl \ # pcntl module
                --enable-shmop \ # shmop module
                --enable-soap \ # soap module
                --enable-sockets \ # sockets module
                --enable-sysvsem \ # sysvsem module
                --enable-xml \ # xml module
                --enable-zip # zip module
            # make it
            make && make install
            # create soft linker
            ln -s /usr/bin/php-fpm /lty-make/package/php/bin/php-fpm
            # start service
            service php-fpm start
        cd ..
    elif [[ $2 == "c" || $2 == "c++" || $2 == "gcc" || $2 == "pascal" || $2 == "fortran" ]]; then # Compiling package gcc
        # get source code online
        wget -O /lty-make/download/gcc.tar.gz http://mirrors.kernel.org/gnu/gcc/gcc-9.3.0/gcc-9.3.0.tar.gz
        # tar it
        tar -xzvf /lty-make/download/gcc.tar.gz /lty-make/download/gcc
        cd gcc # /lty-make/download/gcc
            # configure it and create Makefile
            ./configure --prefix=/lty-make/package/gcc --enable-languages=c,c++,objc,java,fortran,pascal
            # make it
            make && make install
            # create soft linker
            ln -s /usr/bin/gcc /lty-make/package/gcc/bin/gcc
            ln -s /usr/bin/g++ /lty-make/package/gcc/bin/g++
            ln -s /usr/bin/gfortran /lty-make/package/gcc/bin/gfortran
            ln -s /usr/bin/gpc /lty-make/package/gcc/bin/gpc
        cd ..
    elif [[ $2 == "make" ]]; then # Compiling package make
        # get source code online
        wget -O /lty-make/download/make.tar.gz http://mirrors.kernel.org/gnu/make/make-4.3.tar.gz
        # tar it
        tar -xzvf /lty-make/download/make.tar.gz /lty-make/download/make
        cd make # /lty-make/download/make
            # configure it and create Makefile
            ./configure --prefix=/lty-make/package/make
            # make it
            make && make install
            # create soft linker
            ln -s /usr/bin/make /lty-make/package/make/bin/make
    elif [[ $2 == "git" ]]; then # Compiling package git
        # get source code online
        wget -O /lty-make/download/git.tar.gz http://mirrors.kernel.org/gnu/git/gnuit-4.9.5.tar.gz
        # tar it
        tar -xzvf /lty-make/download/git.tar.gz /lty-make/download/git
        cd git # /lty-make/download/git
            # configure it and create Makefile
            ./configure --prefix=/lty-make/package/git
            # make it
            make && make install
            # create soft linker
            ln -s /usr/bin/git /lty-make/package/git/bin/git
    elif [[ $2 == "bash" ]]; then # Compiling package bash
        # get source code online
        wget -O /lty-make/download/bash.tar.gz http://mirrors.kernel.org/gnu/bash/bash-5.0.tar.gz
        # tar it
        tar -xzvf /lty-make/download/bash.tar.gz /lty-make/download/bash
        cd bash # /lty-make/download/bash
            # configure it and create Makefile
            ./configure --prefix=/lty-make/package/bash
            # make it
            make && make install
            # create soft linker
            ln -s /usr/bin/bash /lty-make/package/bash/bin/bash
    elif [[ $2 == "python" ]]; then # Compiling package python
        # get source code online
        wget -O /lty-make/download/python.tar.gz https://www.python.org/ftp/python/3.9.0/Python-3.9.0rc1.tgz
        # tar it
        tar -xzvf /lty-make/download/python.tar.gz /lty-make/download/python
        cd python # /lty-make/download/python
            # configure it and create Makefile
            ./configure --prefix=/lty-make/package/python
            # make it
            make && make install
            # create soft linker
            ln -s /lty-make/package/python/bin/python3 /usr/bin/python3
            ln -s /lty-make/package/python/bin/pip3 /usr/bin/pip3
    elif [[ $2 == "apache" ]]; then # Compiling package apache
        # get source code online
        wget -O /lty-make/download/apache.tar.gz http://www-us.apache.org/dist//httpd/httpd-2.4.34.tar.gz
        # tar it
        tar -xzvf /lty-make/download/apache.tar.gz /lty-make/download/apache
        cd apache # /lty-make/download/apache
            # configure it and create Makefile
            ./configure --prefix=/lty-make/package/apache
            # make it
            make && make install
            # create soft linker
            ln -s /lty-make/package/apache/bin/httpd /usr/bin/httpd
    elif [[ $2 == "nginx" ]]; then # Compiling package nginx
        # get source code online
        wget -O /lty-make/download/nginx.tar.gz http://nginx.org/download/nginx-1.19.2.tar.gz
        # tar it
        tar -xzvf /lty-make/download/nginx.tar.gz /lty-make/download/nginx
        cd nginx # /lty-make/download/nginx
            # configure it and create Makefile
            ./configure --prefix=/lty-make/package/nginx
            # make it
            make && make install
            # create soft linker
            ln -s /lty-make/package/apache/bin/nginx /usr/bin/nginx
            # start nginx service
            nginx start &
    fi
    rm -rf /lty-make/download
elif [[ $# -eq 2 && $1 == "remove" ]]; then # install package
    if [[ $2 == "require" ]]; then
        rm -rf /lty-make/package/m4 /usr/bin/m4 # remove package m4
        rm -rf /lty-make/package/m4 /usr/bin/gmp # remove package gmp
        rm -rf /lty-make/package/m4 /usr/bin/mpfr # remove package mpfr
        rm -rf /lty-make/package/m4 /usr/bin/mpc # remove package mpc
        rm -rf /lty-make/package/apr /usr/bin/apr # remove package apr
        rm -rf /lty-make/package/apr-utils /usr/bin/apr-utils # remove package apr-utils
        rm -rf /lty-make/package/pcre /usr/bin/pcre # remove package pcre
        rm -rf /lty-make/package/boost /usr/bin/boost # remove package boost
    # else
    #     rm -rf /lty-make/package/$2 /usr/bin/$2
    # fi
    # For safety, I won't to do this.
    # it means if $2 == ".." then is will do "rm -rf /lty-make/.." and remove /
    elif [[ $2 == "c" || $2 == "c++" || $2 == "gcc" || $2 == "pascal" || $2 == "fortran" ]]; then
        rm -rf /lty-make/package/gcc /usr/bin/gcc # remove package gcc
    elif [[ $2 == "make" ]]; then
        rm -rf /lty-make/package/make /usr/bin/make # remove package make
    elif [[ $2 == "git" ]]; then
        rm -rf /lty-make/package/git /usr/bin/git # remove package git
    elif [[ $2 == "bash" ]]; then
        rm -rf /lty-make/package/bash /usr/bin/bash # remove package bash
    elif [[ $2 == "python" ]]; then
        rm -rf  /lty-make/package/python /usr/bin/python3 /usr/bin/pip3 # remove package python
    elif [[ $2 == "apache" ]]; then
        rm -rf /lty-make/package/apache /usr/bin/httpd # remove package apache
    elif [[ $2 == "nginx" ]]; then
        rm -rf /lty-make/package/nginx /usr/bin/nginx # remove package nginx
    elif [[ $2 == "mysql" ]]; then
        rm -rf /lty-make/package/mysql /usr/bin/mysql # remove package mysql 
    fi
elif [[ $# -eq 7 && $1 == "compiler" ]]; then # old compile
    for i in $2; do
        echo "Compiling $i to object file..." # compile 
        $2 $3 $6 $5 $i /tmp/$i.obj || exit $? # compile to object
        $objects="$objects /tmp/$i.obj" # add to $objects
    done
    echo "Linking everthing together..." # link
    $2 $3 $objects $5 $7 || exit $? # linking $objects
else # Help
    Help || exit $? # me too.
fi
echo "done."