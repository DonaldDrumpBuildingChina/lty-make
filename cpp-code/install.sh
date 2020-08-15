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
cd /lty-make/download 
if [[ $1 == "require" ]]; then
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
elif [[ $1 == "mysql" ]]; then # Compiling package mysql
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
elif [[ $1 == "php" ]]; then # Compiling package php
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
elif [[ $1 == "c" || $1 == "c++" || $1 == "gcc" || $1 == "pascal" || $1 == "fortran" ]]; then # Compiling package gcc
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
elif [[ $1 == "make" ]]; then # Compiling package make
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
elif [[ $1 == "git" ]]; then # Compiling package git
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
elif [[ $1 == "bash" ]]; then # Compiling package bash
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
elif [[ $1 == "python" ]]; then # Compiling package python
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
elif [[ $1 == "apache" ]]; then # Compiling package apache
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
elif [[ $1 == "nginx" ]]; then # Compiling package nginx
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
if [[ $1 == "require" ]]; then
    rm -rf /lty-make/package/m4 /usr/bin/m4 # remove package m4
    rm -rf /lty-make/package/m4 /usr/bin/gmp # remove package gmp
    rm -rf /lty-make/package/m4 /usr/bin/mpfr # remove package mpfr
    rm -rf /lty-make/package/m4 /usr/bin/mpc # remove package mpc
    rm -rf /lty-make/package/apr /usr/bin/apr # remove package apr
    rm -rf /lty-make/package/apr-utils /usr/bin/apr-utils # remove package apr-utils
    rm -rf /lty-make/package/pcre /usr/bin/pcre # remove package pcre
    rm -rf /lty-make/package/boost /usr/bin/boost # remove package boost
# else
#     rm -rf /lty-make/package/$1 /usr/bin/$1
# fi
# For safety, I won't to do this.
# it means if $1 == ".." then is will do "rm -rf /lty-make/.." and remove /
elif [[ $1 == "c" || $1 == "c++" || $1 == "gcc" || $1 == "pascal" || $1 == "fortran" ]]; then
    rm -rf /lty-make/package/gcc /usr/bin/gcc # remove package gcc
elif [[ $1 == "make" ]]; then
    rm -rf /lty-make/package/make /usr/bin/make # remove package make
elif [[ $1 == "git" ]]; then
    rm -rf /lty-make/package/git /usr/bin/git # remove package git
elif [[ $1 == "bash" ]]; then
    rm -rf /lty-make/package/bash /usr/bin/bash # remove package bash
elif [[ $1 == "python" ]]; then
    rm -rf  /lty-make/package/python /usr/bin/python3 /usr/bin/pip3 # remove package python
elif [[ $1 == "apache" ]]; then
    rm -rf /lty-make/package/apache /usr/bin/httpd # remove package apache
elif [[ $1 == "nginx" ]]; then
    rm -rf /lty-make/package/nginx /usr/bin/nginx # remove package nginx
elif [[ $1 == "mysql" ]]; then
    rm -rf /lty-make/package/mysql /usr/bin/mysql # remove package mysql 
fi