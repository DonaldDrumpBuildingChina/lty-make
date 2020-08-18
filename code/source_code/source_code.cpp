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
#include "source_code.hpp"
source_code::source_code(std::string _filename){ 
    filename = _filename;
    name = filename.substr(0, filename.find_last_of(".")+1);
    suffix = filename.substr(filename.find_last_of(".")+1, filename.end()-filename.begin());
    object_name = stringplus((std::initializer_list<std::string>){"/tmp/", name, ".obj"});
    compilers["c"]=std::pair<std::string, std::string>("gcc", getenv("cflag"));
    compilers["cpp"]=compilers["cxx"]=compilers["C"]=std::pair<std::string, std::string>("g++", getenv("cxxflag"));
    compilers["pas"]=std::pair<std::string, std::string>("gpc", getenv("pasflag"));
    compilers["f90"]=compilers["f95"]=compilers["f"]=compilers["for"]=\
    std::pair<std::string, std::string>("gfortran", getenv("forflag"));
    compilers["java"]=std::pair<std::string, std::string>("gcj", getenv("javaflag"));
}
std::pair<std::string, std::string> source_code::auto_compile(){ 
    if(new_file("/lty-make/md5sum.txt")){
        if(compilers.find(suffix)==compilers.end()){
            throw std::runtime_error("错误：找不到文件类型。");
        }
        system(stringplus((std::initializer_list<std::string>){compilers[suffix].first, "-c",\
        filename, compilers[suffix].second,"-o",\
        object_name}).c_str());
    }
    return compilers[suffix];
}
bool source_code::new_file(std::string _filename){ 
    struct stat source_time, object_time;
    FILE *source = fopen(filename.c_str(), "r"), *object = fopen(object_name.c_str(),"r");
    fstat(fileno(source),&source_time),fclose(source);
    fstat(fileno(object),&object_time),fclose(object);
    return source_time.st_mtim.tv_nsec>object_time.st_mtim.tv_nsec;
}
inline std::string source_code::getName(){
    return filename;
}
inline std::string source_code::getname(){
    return name;
}
inline std::string source_code::getsuffix(){
    return suffix;
}
inline std::string source_code::getObjectName(){
    return object_name;
}