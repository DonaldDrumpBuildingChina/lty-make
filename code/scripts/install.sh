#!/bin/bash
if [[ $# -eq 2 && $1 == "install" ]]; then
    cd /lty-make/download 
    if [[ $2 == "require" ]]; then
            wget -O /lty-make/download/m4.tar.gz http://mirrors.kernel.org/gnu/m4/m4-latest.tar.gz
            tar -xzvf /lty-make/download/m4.tar.gz /lty-make/download/m4
            cd m4
                ./configure --prefix=/lty-make/package/m4
                make && make install 
        cd ..
            wget -O /lty-make/download/gmp.tar.zst http://mirrors.kernel.org/gnu/gmp/gmp-6.2.0.tar.zst
            tar -I zstd -xvf gmp.tar.zst /lty-make/doenload/gmp
            cd gmp
                ./configure --prefix=/lty-make/package/gmp
                make && make install
        cd ..
            wget -O /lty-make/download/mpfr.tar.gz http://mirrors.kernel.org/gnu/mpfr/mpfr-4.1.0.tar.gz
            tar -xzvf /lty-make/download/mpfr.tar.gz /lty-make/download/mpfr
            cd mpfr
                ./configure --prefix=/lty-make/package/mpfr --with-gmp=/lty-make/package/gmp
                make && make install
        cd ..
            wget -O /lty-make/download/mpc.tar.gz http://mirrors.kernel.org/gnu/mpc/mpc-1.0.1.tar.gz
            tar -xzvf /lty-make/download/mpc.tar.gz /lty-make/download/mpc
            cd mpc
                ./configure --prefix=/lty-make/package/mpc --with-gmp=/lty-make/package/gmp
                make && make install
        cd ..
            wget -O /lty-make/download/apr.tar.gz http://archive.apache.org/dist/apr/apr-1.4.5.tar.gz
            tar -xzvf /lty-make/download/apr.tar.gz /lty-make/download/apr
            cd apr
                ./configure --prefix=/lty-make/package/apr
                make && make install
        cd ..
            wget -O /lty-make/download/apr-utill.tar.gz http://archive.apache.org/dist/apr/apr-util-1.3.12.tar.gz
            tar -xzvf /lty-make/download/apr-utill.tar.gz /lty-make/download/apr-utill
            cd apr-utill
                ./configure --prefix=/lty-make/package/apr-utill
                make && make install
        cd ..
            wget -O /lty-make/download/pcre.zip http://jaist.dl.sourceforge.net/project/pcre/pcre/8.10/pcre-8.10.zip 
            unzip /lty-make/download/pcre.zip -d /lty-make/download/pcre
            cd pcre
                ./configure --prefix=/lty-make/package/pcre
                make && make install
        cd ..
            wget -O /lty-make/download/boost.tar.gz http://www.sourceforge.net/projects/boost/files/boost/1.59.0/boost_1_59_0.tar.gz
            tar -xzvf /lty-make/download/boost.tar.gz /lty-make/download/boost
            cd boost
                ./configure --prefix=/lty-make/package/boost
                make && make install
                ln -s /usr/bin/boost /lty-make/package/apr/bin/boost
    elif [[ $2 == "mysql" ]]; then
        wget -O /lty-make/download/mysql.tar.gz https://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-5.7.24.tar.gz
        tar -xzvf /lty-make/download/mysql.tar.gz /lty-make/download/mysql
        cd mysql
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
    elif [[ $2 == "php" ]]; then
        wget -O /lty-make/download/php.tar.gz http://php.net/distributions/php-7.4.0.tar.gz
        tar -xzvf /lty-make/download/php.tar.gz /lty-make/download/php
        cd php
            groupadd php
            useradd -g php php
            ./configure \
                --prefix=/lty-make/package/php \
                --with-config-file-path=/lty-make/package/php/config \
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
                --enable-xml \
                --enable-zip
            make && make install
            service php-fpm start
        cd ..
    elif [[ $2 == "c" || $2 == "c++" || $2 == "gcc" || $2 == "pascal" || $2 == "fortran" ]]; then
        wget -O /lty-make/download/gcc.tar.gz http://mirrors.kernel.org/gnu/gcc/gcc-9.3.0/gcc-9.3.0.tar.gz
        tar -xzvf /lty-make/download/gcc.tar.gz /lty-make/download/gcc
        cd gcc
            ./configure --prefix=/lty-make/package/gcc --enable-languages=c,c++,objc,java,fortran,pascal
        cd ..
    elif [[ $2 == "make" ]]; then
        wget -O /lty-make/download/make.tar.gz http://mirrors.kernel.org/gnu/make/make-4.3.tar.gz
        tar -xzvf /lty-make/download/make.tar.gz /lty-make/download/make
        cd make
            ./configure --prefix=/lty-make/package/make
            make && make install
    elif [[ $2 == "git" ]]; then
        wget -O /lty-make/download/git.tar.gz http://mirrors.kernel.org/gnu/git/gnuit-4.9.5.tar.gz
        tar -xzvf /lty-make/download/git.tar.gz /lty-make/download/git
        cd git
            ./configure --prefix=/lty-make/package/git
            make && make install
    elif [[ $2 == "bash" ]]; then
        wget -O /lty-make/download/bash.tar.gz http://mirrors.kernel.org/gnu/bash/bash-5.0.tar.gz
        tar -xzvf /lty-make/download/bash.tar.gz /lty-make/download/bash
        cd bash
            ./configure --prefix=/lty-make/package/bash
            make && make install
    elif [[ $2 == "python" ]]; then
        wget -O /lty-make/download/python.tar.gz https://www.python.org/ftp/python/3.9.0/Python-3.9.0rc1.tgz
        tar -xzvf /lty-make/download/python.tar.gz /lty-make/download/python
        cd python
            ./configure --prefix=/lty-make/package/python
            make && make install
    elif [[ $2 == "apache" ]]; then
        wget -O /lty-make/download/apache.tar.gz http://www-us.apache.org/dist//httpd/httpd-2.4.34.tar.gz
        tar -xzvf /lty-make/download/apache.tar.gz /lty-make/download/apache
        cd apache
            ./configure --prefix=/lty-make/package/apache
            make && make install
            ln -s /lty-make/package/apache/bin/httpd /usr/bin/httpd
    elif [[ $2 == "nginx" ]]; then
        wget -O /lty-make/download/nginx.tar.gz http://nginx.org/download/nginx-1.19.2.tar.gz
        tar -xzvf /lty-make/download/nginx.tar.gz /lty-make/download/nginx
        cd nginx
            ./configure --prefix=/lty-make/package/nginx
            make && make install
            nginx start
    fi
    rm -rf /lty-make/download
elif [[ $# -eq 2 && $1 == "remove" ]]; then
    if [[ $2 == "require" ]]; then
        rm -rf /lty-make/package/m4 /usr/bin/m4
        rm -rf /lty-make/package/m4 /usr/bin/gmp
        rm -rf /lty-make/package/m4 /usr/bin/mpfr
        rm -rf /lty-make/package/m4 /usr/bin/mpc
        rm -rf /lty-make/package/apr /usr/bin/apr
        rm -rf /lty-make/package/apr-utils /usr/bin/apr-utils
        rm -rf /lty-make/package/pcre /usr/bin/pcre
        rm -rf /lty-make/package/boost /usr/bin/boost
    elif [[ $2 == "c" || $2 == "c++" || $2 == "gcc" || $2 == "pascal" || $2 == "fortran" ]]; then
        rm -rf /lty-make/package/gcc /usr/bin/gcc
    elif [[ $2 == "make" ]]; then
        rm -rf /lty-make/package/make /usr/bin/make
    elif [[ $2 == "git" ]]; then
        rm -rf /lty-make/package/git /usr/bin/git
    elif [[ $2 == "bash" ]]; then
        rm -rf /lty-make/package/bash /usr/bin/bash
    elif [[ $2 == "python" ]]; then
        rm -rf  /lty-make/package/python /usr/bin/python3 /usr/bin/pip3
    elif [[ $2 == "apache" ]]; then
        rm -rf /lty-make/package/apache /usr/bin/httpd
    elif [[ $2 == "nginx" ]]; then
        rm -rf /lty-make/package/nginx /usr/bin/nginx
    elif [[ $2 == "mysql" ]]; then
        rm -rf /lty-make/package/mysql /usr/bin/mysql
    fi
else
    help.sh
fi