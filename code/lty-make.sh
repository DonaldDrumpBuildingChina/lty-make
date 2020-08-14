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
                ln -s /usr/bin/m4 /lty-make/package/m4/bin/m4
        cd ..
            wget -O /lty-make/download/gmp.tar.zst http://mirrors.kernel.org/gnu/gmp/gmp-6.2.0.tar.zst
            tar -I zstd -xvf gmp.tar.zst /lty-make/doenload/gmp
            cd gmp # /lty-make/download/gmp
                ./configure --prefix=/lty-make/package/gmp
                make && make install
                ln -s /usr/bin/gmp /lty-make/package/gmp/bin/gmp
        cd ..
            wget -O /lty-make/download/mpfr.tar.gz http://mirrors.kernel.org/gnu/mpfr/mpfr-4.1.0.tar.gz
            tar -xzvf /lty-make/download/mpfr.tar.gz /lty-make/download/mpfr
            cd mpfr # /lty-make/download/mpfr
                ./configure --prefix=/lty-make/package/mpfr --with-gmp=/lty-make/package/gmp
                make && make install
                ln -s /usr/bin/mpfr /lty-make/package/mpfr/bin/mpfr
        cd ..
            wget -O /lty-make/download/mpc.tar.gz http://mirrors.kernel.org/gnu/mpc/mpc-1.0.1.tar.gz
            tar -xzvf /lty-make/download/mpc.tar.gz /lty-make/download/mpc
            cd mpc # /lty-make/download/mpc
                ./configure --prefix=/lty-make/package/mpc --with-gmp=/lty-make/package/gmp
                make && make install
                ln -s /usr/bin/mpc /lty-make/package/mpc/bin/mpc
        cd ..
            wget -O /lty-make/download/apr.tar.gz http://archive.apache.org/dist/apr/apr-1.4.5.tar.gz
            tar -xzvf /lty-make/download/apr.tar.gz /lty-make/download/apr
            cd apr # /lty-make/download/apr
                ./configure --prefix=/lty-make/package/apr
                make && make install
                ln -s /usr/bin/apr /lty-make/package/apr/bin/apr
        cd ..
            wget -O /lty-make/download/apr-utill.tar.gz http://archive.apache.org/dist/apr/apr-util-1.3.12.tar.gz
            tar -xzvf /lty-make/download/apr-utill.tar.gz /lty-make/download/apr-utill
            cd apr-utill # /lty-make/download/apr-utill
                ./configure --prefix=/lty-make/package/apr-utill
                make && make install
                ln -s /usr/bin/apr-utill /lty-make/package/apr/bin/apr-utill
        cd ..
            wget -O /lty-make/download/pcre.zip http://jaist.dl.sourceforge.net/project/pcre/pcre/8.10/pcre-8.10.zip  
            unzip /lty-make/download/pcre.zip -d /lty-make/download/pcre
            cd pcre # /lty-make/download/pcre
                ./configure --prefix=/lty-make/package/pcre
                make && make install
                ln -s /usr/bin/pcre /lty-make/package/apr/bin/pcre
        cd ..
            wget -O /lty-make/download/boost.tar.gz http://www.sourceforge.net/projects/boost/files/boost/1.59.0/boost_1_59_0.tar.gz
            tar -xzvf /lty-make/download/boost.tar.gz /lty-make/download/boost
            cd boost # /lty-make/download/boost
                ./configure --prefix=/lty-make/package/boost
                make && make install
                ln -s /usr/bin/boost /lty-make/package/apr/bin/boost
        cd ..
            wget -O /lty-make/download/mysql.tar.gz https://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-5.7.24.tar.gz
            tar -xzvf /lty-make/download/mysql.tar.gz /lty-make/download/mysql
            cd mysql # /lty-make/download/mysql
                cmake -DCMAKE_INSTALL_PREFIX=/lty-make/package/mysql \
                    -DWITH_BOOST=/lty-make/package/boost \
                    -DMYSQL_UNIX_ADDR=/lty-make/package/mysql/tmp/mysql.sock \
                    -DMYSQL_DATADIR=/lty-make/package/mysql/data \
                    -DDEFAULT_CHARSET=utf8mb4 \
                    -DDEFAULT_COLLATION=utf8mb4_general_ci \
                    -DWITH_EXTRA_CHARSETS=all \
                    -DWITH_MYISAM_STORAGE_ENGINE=1 \
                    -DWITH_INNOBASE_STORAGE_ENGINE=1 \
                    -DWITH_MEMORY_STORAGE_ENGINE=1 \
                    -DWITH_READLINE=1 \
                    -DWITH_INNODB_MEMCACHED=1 \
                    -DWITH_DEBUG=OFF \
                    -DWITH_ZLIB=bundled \
                    -DENABLED_LOCAL_INFILE=1 \
                    -DENABLED_PROFILING=ON \
                    -DMYSQL_MAINTAINER_MODE=OFF \
                    -DMYSQL_TCP_PORT=3306
                make && make install
                ln -s /usr/bin/mysql /lty-make/package/mysql/bin/mysql
        cd ..
        wget -O /lty-make/download/php.tar.gz http://php.net/distributions/php-7.4.0.tar.gz
            tar -xzvf /lty-make/download/php.tar.gz /lty-make/download/php
            cd php # /lty-make/download/php
                groupadd php
                useradd -g php php
                ./configure \ 
                    --prefix=/lty-make/package/php \ 
                    --with-config-file-path=/etc \ 
                    --with-fpm-user=php \ 
                    --with-fpm-group=php \  
                    --with-curl \ 
                    --with-freetype-dir \ 
                    --enable-gd \ 
                    --with-gettext \  
                    --with-iconv-dir \ 
                    --with-kerberos \ 
                    --with-libdir=lib64 \ 
                    --with-libxml-dir \ 
                    --with-mysqli \ 
                    --with-openssl \ 
                    --with-pcre-regex \ 
                    --with-pdo-mysql \ 
                    --with-pdo-sqlite \ 
                    --with-pear \ 
                    --with-png-dir \ 
                    --with-jpeg-dir \ 
                    --with-xmlrpc \ 
                    --with-xsl \ 
                    --with-zlib \ 
                    --with-bz2 \ 
                    --with-mhash \ 
                    --enable-fpm \ 
                    --enable-bcmath \ 
                    --enable-libxml \ 
                    --enable-inline-optimization \ 
                    --enable-mbregex \ 
                    --enable-mbstring \ 
                    --enable-opcache \ 
                    --enable-pcntl \ 
                    --enable-shmop \ 
                    --enable-soap \ 
                    --enable-sockets \ 
                    --enable-sysvsem \ 
                    --enable-sysvshm \ 
                    --enable-xml \  
                    --enable-zip \ 
                    --enable-fpm
                make && make install
                ln -s /usr/bin/php-fpm /lty-make/package/php/bin/php-fpm
                service php-fpm start
        cd ..
    elif [[ $2 == "c" || $2 == "c++" || $2 == "gcc" || $2 == "pascal" || $2 == "fortran" ]]; then
        cd /lty-make/download
            wget -O /lty-make/download/gcc.tar.gz http://mirrors.kernel.org/gnu/gcc/gcc-9.3.0/gcc-9.3.0.tar.gz
            tar -xzvf /lty-make/download/gcc.tar.gz /lty-make/download/gcc
            cd gcc # /lty-make/download/gcc
                ./configure --prefix=/lty-make/package/gcc --enable-languages=c,fortran,pascal
                make && make install
                ln -s /usr/bin/gcc /lty-make/package/gcc/bin/gcc
                ln -s /usr/bin/g++ /lty-make/package/gcc/bin/g++
                ln -s /usr/bin/gfortran /lty-make/package/gcc/bin/gfortran
                ln -s /usr/bin/gpc /lty-make/package/gcc/bin/gpc
        cd ..
    elif [ $2 == "make" ]; then
        cd /lty-make/download
            wget -O /lty-make/download/make.tar.gz http://mirrors.kernel.org/gnu/make/make-4.3.tar.gz
            tar -xzvf /lty-make/download/make.tar.gz /lty-make/download/make
            cd make # /lty-make/download/make
                ./configure --prefix=/lty-make/package/make
                make && make install
                ln -s /usr/bin/make /lty-make/package/make/bin/make
        cd ..
    elif [ $2 == "git" ]; then
        cd /lty-make/download
            wget -O /lty-make/download/git.tar.gz http://mirrors.kernel.org/gnu/git/gnuit-4.9.5.tar.gz
            tar -xzvf /lty-make/download/git.tar.gz /lty-make/download/git
            cd git # /lty-make/download/git
                ./configure --prefix=/lty-make/package/git
                make && make install
                ln -s /usr/bin/git /lty-make/package/git/bin/git
        cd ..
    elif [ $2 == "bash" ]; then
        cd /lty-make/download
            wget -O /lty-make/download/bash.tar.gz http://mirrors.kernel.org/gnu/bash/bash-5.0.tar.gz
            tar -xzvf /lty-make/download/bash.tar.gz /lty-make/download/bash
            cd bash # /lty-make/download/bash
                ./configure --prefix=/lty-make/package/bash
                make && make install
                ln -s /usr/bin/bash /lty-make/package/bash/bin/bash
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
    elif [ $2 == "apache" ]; then
        cd /lty-make/download
            wget -O /lty-make/download/apache.tar.gz http://www-us.apache.org/dist//httpd/httpd-2.4.34.tar.gz
            tar -xzvf /lty-make/download/apache.tar.gz /lty-make/download/apache
            cd apache # /lty-make/download/apache
                ./configure --prefix=/lty-make/package/apache
                make && make install
                ln -s /lty-make/package/apache/bin/httpd /usr/bin/httpd
        cd ..
    elif [ $2 == "nginx" ]; then
        cd /lty-make/download
            wget -O /lty-make/download/nginx.tar.gz http://nginx.org/download/nginx-1.19.2.tar.gz
            tar -xzvf /lty-make/download/nginx.tar.gz /lty-make/download/nginx
            cd nginx # /lty-make/download/nginx
                ./configure --prefix=/lty-make/package/nginx
                make && make install
                ln -s /lty-make/package/apache/bin/nginx /usr/bin/nginx
                nginx start &
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
