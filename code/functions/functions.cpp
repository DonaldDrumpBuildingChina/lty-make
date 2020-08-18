/*#####################################################################
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
######################################################################*/
#include "functions.hpp"
template <typename T> std::string stringplus(const T& list){
    std::string tmp;
    for (auto it = list.begin(); it != list.end(); it++) tmp+=*it,tmp+=" ";
    return tmp;
}
template <typename T> std::string tostring(const T& n){
    std::stringstream stream;
    std::string tmp;
    stream<<n;
    stream>>tmp;
    return tmp;
}
void set(std::string name, std::string value){
    setenv(name.c_str(), value.c_str(), 1);
}
std::vector<std::thread*> threads;
void dir(std::string _dir, void (*word)(std::string), bool r, int depth){
    DIR* p_dir = NULL;
    struct dirent* p_entry = NULL;
    struct stat statbuf;
    if ((p_dir = opendir(_dir.c_str())) == NULL) return;
    chdir(_dir.c_str());
    while (NULL != (p_entry = readdir(p_dir))) {
        lstat(p_entry->d_name, &statbuf);
        if (S_IFDIR & statbuf.st_mode) {
            if (std::string(p_entry->d_name) == "." || std::string(p_entry->d_name) == "..")
                continue;
            dir(p_entry->d_name, word, r, depth+1);
        } else {
            std::thread* t = new std::thread(word, p_entry->d_name);
            threads.push_back(t);
        }
    }
    chdir("..");
    closedir(p_dir);
}
std::vector<std::string> forstring(std::string str){
    std::string temp;
    temp.resize(100);
    std::vector<std::string> files;
    while(sscanf(str.c_str(),"%s",&temp[0])){
        files.push_back(temp);
    }
    return files;
}
void help(void){
    std::cerr<<"错误：无效的命令行！"<<std::endl;
    //system("cat ../README.md >&2");
    exit(1);
}
void package(bool flag, std::string name){
    system("cd /lty-make/download");
    std::map<std::string, void(*)()> install,remove;
    install["require"]=[](){
        std::thread m4([](){
            system("wget -O /lty-make/download/m4.tar.gz http://mirrors.kernel.org/gnu/m4/m4-latest.tar.gz");
            system("tar -xzvf /lty-make/download/m4.tar.gz /lty-make/download/m4");
        });
        std::thread gmp([](){
            system("wget -O /lty-make/download/gmp.tar.zst http://mirrors.kernel.org/gnu/gmp/gmp-6.2.0.tar.zst");
            system("tar -I zstd -xvf gmp.tar.zst /lty-make/doenload/gmp");
        });
        std::thread mpfr([](){
            system("wget -O /lty-make/download/mpfr.tar.gz http://mirrors.kernel.org/gnu/mpfr/mpfr-4.1.0.tar.gz");
            system("tar -xzvf /lty-make/download/mpfr.tar.gz /lty-make/download/mpfr");
        });
        std::thread mpc([](){
            system("wget -O /lty-make/download/mpc.tar.gz http://mirrors.kernel.org/gnu/mpc/mpc-1.0.1.tar.gz");
            system("tar -xzvf /lty-make/download/mpc.tar.gz /lty-make/download/mpc");
        });
        std::thread apr([](){
            system("wget -O /lty-make/download/apr.tar.gz http://archive.apache.org/dist/apr/apr-1.4.5.tar.gz");
            system("tar -xzvf /lty-make/download/apr.tar.gz /lty-make/download/apr");
        });
        std::thread apr_utill([](){
            system("wget -O /lty-make/download/apr-utill.tar.gz http://archive.apache.org/dist/apr/apr-util-1.3.12.tar.gz");
            system("tar -xzvf /lty-make/download/apr-utill.tar.gz /lty-make/download/apr-utill");
        });
        std::thread pcre([](){
            system("wget -O /lty-make/download/pcre.zip http://jaist.dl.sourceforge.net/project/pcre/pcre/8.10/pcre-8.10.zip");
            system("unzip /lty-make/download/pcre.zip -d /lty-make/download/pcre");
        });
        std::thread boost([](){
            system("wget -O /lty-make/download/boost.tar.gz http://www.sourceforge.net/projects/boost/files/boost/1.59.0/boost_1_59_0.tar.gz");
            system("tar -xzvf /lty-make/download/boost.tar.gz /lty-make/download/boost");
        });
        m4.join();
            system("cd m4");
            system("./configure --prefix=/lty-make/package/m4");
            system("make && make install"); 
            system("cd ..");
        gmp.join();
            system("cd gmp");
            system("./configure --prefix=/lty-make/package/gmp");
            system("make && make install");
        mpfr.join();
            system("cd mpfr");
            system("./configure --prefix=/lty-make/package/mpfr");
            system("make && make install"); 
            system("cd ..");
        mpc.join();
            system("cd mpc");
            system("./configure --prefix=/lty-make/package/mpc");
            system("make && make install"); 
            system("cd ..");
        apr.join();
            system("cd apr");
            system("./configure --prefix=/lty-make/package/apr");
            system("make && make install"); 
            system("cd ..");
        apr_utill.join();
            system("cd apr-utill");
            system("./configure --prefix=/lty-make/package/apr-utill");
            system("make && make install"); 
            system("cd ..");
        pcre.join();
            system("cd pcre");
            system("./configure --prefix=/lty-make/package/pcre");
            system("make && make install"); 
            system("cd ..");   
        boost.join();
            system("cd boost");
            system("./configure --prefix=/lty-make/package/boost");
            system("make && make install"); 
            system("cd ..");
    };
    install["mysql"]=[](){
        system("wget -O /lty-make/download/mysql.tar.gz https://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-5.7.24.tar.gz");
        system("tar -xzvf /lty-make/download/mysql.tar.gz /lty-make/download/mysql");
        system("cd mysql");
            system("cmake -DCMAKE_INSTALL_PREFIX=/lty-make/package/mysql "
                "-DWITH_BOOST=/lty-make/package/boost "
                "-DMYSQL_UNIX_ADDR=/lty-make/package/mysql/tmp/mysql.sock "
                "-DMYSQL_DATADIR=/lty-make/package/mysql/data "
                "-DDEFAULT_CHARSET=utf8mb4 "
                "-DDEFAULT_COLLATION=utf8mb4_general_ci "
                "-DWITH_EXTRA_CHARSETS=all "
                "-DWITH_MYISAM_STORAGE_ENGINE=1 "
                "-DWITH_INNOBASE_STORAGE_ENGINE=1 "
                "-DWITH_MEMORY_STORAGE_ENGINE=1 "
                "-DWITH_READLINE=1 "
                "-DWITH_INNODB_MEMCACHED=1 "
                "-DWITH_DEBUG=OFF "
                "-DWITH_ZLIB=bundled "
                "-DENABLED_LOCAL_INFILE=1 "
                "-DENABLED_PROFILING=ON "
                "-DMYSQL_MAINTAINER_MODE=OFF "
                "-DMYSQL_TCP_PORT=3306");
            system("make && make install");
    };
    install["php"]=[](){
        system("wget -O /lty-make/download/php.tar.gz http://php.net/distributions/php-7.4.0.tar.gz");
        system("tar -xzvf /lty-make/download/php.tar.gz /lty-make/download/php");
        system("cd php");
            system("groupadd php");
            system("useradd -g php php");
            system("./configure --prefix=/lty-make/package/php " 
                "--with-config-file-path=/lty-make/package/php/config "
                "--with-fpm-user=php --with-fpm-group=php --with-curl "
                "--with-freetype-dir --enable-gd --with-gettext "
                "--with-iconv-dir --with-kerberos --with-libdir=lib64 "
                "--with-libxml-dir --with-mysqli --with-openssl "
                "--with-pcre-regex --with-pdo-mysql --with-pdo-sqlite "
                "--with-pear --with-png-dir --with-jpeg-dir --with-xmlrpc "
                "--with-xsl --with-zlib --with-bz2 --with-mhash --enable-fpm "
                "--enable-bcmath --enable-libxml --enable-inline-optimization "
                "--enable-mbregex --enable-mbstring --enable-opcache --enable-pcntl "
                "--enable-shmop --enable-soap --enable-sockets --enable-sysvsem "
                "--enable-xml --enable-zip");
            system("make && make install");
            system("service php-fpm start");
    };
    install["c"]=install["c++"]=install["pascal"]=install["fortran"]=install["gcc"]=[](){
        system("wget -O /lty-make/download/gcc.tar.gz http://mirrors.kernel.org/gnu/gcc/gcc-9.3.0/gcc-9.3.0.tar.gz");
        system("tar -xzvf /lty-make/download/gcc.tar.gz /lty-make/download/gcc");
        system("cd gcc");
            system("./configure --prefix=/lty-make/package/gcc --enable-languages=c,c++,objc,java,fortran,pascal");
            system("make && make install");
    };
    install["make"]=[](){
        system("wget -O /lty-make/download/make.tar.gz http://mirrors.kernel.org/gnu/make/make-4.3.tar.gz");
        system("tar -xzvf /lty-make/download/make.tar.gz /lty-make/download/make");
        system("cd make");
            system("./configure --prefix=/lty-make/package/make");
            system("make && make install");
    };
    install["bash"]=[](){
        system("wget -O /lty-make/download/bash.tar.gz http://mirrors.kernel.org/gnu/bash/bash-5.0.tar.gz");
        system("tar -xzvf /lty-make/download/bash.tar.gz /lty-make/download/bash");
        system("cd bash");
            system("./configure --prefix=/lty-make/package/bash");
            system("make && make install");
    };
    install["python"]=[](){
        system("wget -O /lty-make/download/python.tar.gz https://www.python.org/ftp/python/3.9.0/Python-3.9.0rc1.tgz");
        system("tar -xzvf /lty-make/download/python.tar.gz /lty-make/download/python");
        system("cd python");
            system("./configure --prefix=/lty-make/package/python");
            system("make && make install");
    };
    install["apache"]=[](){
        system("wget -O /lty-make/download/apache.tar.gz http://www-us.apache.org/dist//httpd/httpd-2.4.34.tar.gz");
        system("tar -xzvf /lty-make/download/apache.tar.gz /lty-make/download/apache");
        system("cd apache");
            system("./configure --prefix=/lty-make/package/apache");
            system("make && make install");
    };
    install["nginx"]=[](){
        system("wget -O /lty-make/download/nginx.tar.gz http://nginx.org/download/nginx-1.19.2.tar.gz");
        system("tar -xzvf /lty-make/download/nginx.tar.gz /lty-make/download/nginx");
        system("cd nginx");
            system("./configure --prefix=/lty-make/package/nginx");
            system("make && make install");
            system("nginx start");
    };
    remove["require"]=[](){
        system("rm -rf /lty-make/package/m4");
        system("rm -rf /lty-make/package/gmp");
        system("rm -rf /lty-make/package/mpfr");
        system("rm -rf /lty-make/package/mpc");
        system("rm -rf /lty-make/package/apr");
        system("rm -rf /lty-make/package/apr-utils");
        system("rm -rf /lty-make/package/pcre");
        system("rm -rf /lty-make/package/boost");
    };
    remove["c"]=remove["c++"]=remove["pascal"]=remove["fortran"]=remove["gcc"]=[](){
        system("rm -rf /lty-make/package/gcc");
    };
    remove["make"]=[](){
        system("rm -rf /lty-make/package/make");
    };
    remove["bash"]=[](){
        system("rm -rf /lty-make/package/bash");
    };
    remove["python"]=[](){
        system("rm -rf /lty-make/package/python");
    };
    remove["apache"]=[](){
        system("rm -rf /lty-make/package/apache");
    };
    remove["nginx"]=[](){
        system("rm -rf /lty-make/package/nginx");
    };
    if(flag == false) install[name]();
    else remove[name]();
    system("rm -rf /lty-make/download/*");
}
int mysystem(std::string cmd, bool flag){
    int status = _system(cmd.c_str());
    if(flag == true) return status;
    else if(status != 0) throw std::runtime_error(stringplus(std::initializer_list<std::string>
    {"错误：命令（", cmd, "） 的返回值为", tostring(status)}));
    else return 0;
}