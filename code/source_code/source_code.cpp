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
}
std::pair<std::string, std::string> source_code::auto_compile(){ 
    if(suffix == "c"){
        system(stringplus((std::initializer_list<std::string>){"gcc", filename, getenv("cflag"), " -c -o /tmp/", filename, ".obj"}).c_str()); //C语言
        return std::pair<std::string, std::string>("gcc", getenv("cflag"));
    }else if(suffix == "cpp" || suffix == "cxx" || suffix == "C"){
        system(stringplus((std::initializer_list<std::string>){"g++", filename, getenv("cxxflag"), "-c -o /tmp/", filename, ".obj"}).c_str()); //C++语言
        return std::pair<std::string, std::string>("g++", getenv("cxxflag"));
    }else if(suffix == "pas"){
        system(stringplus((std::initializer_list<std::string>){"gpc", filename, getenv("pasflag"), "-c -o /tmp/", filename, ".obj"}).c_str()); //Pascal语言
        return std::pair<std::string, std::string>("gpc", getenv("pasflag"));
    }else if(suffix == "f90" || suffix == "f95" || suffix == "f" || suffix == "for"){
        system(stringplus((std::initializer_list<std::string>){"gfortran", filename, getenv("forflag"), "-c -o /tmp/", filename, ".obj"}).c_str()); //Fortran语言
        return std::pair<std::string, std::string>("gfortran", getenv("forflag"));
    }else if(suffix == "java"){
        system(stringplus((std::initializer_list<std::string>){"gcj", filename, getenv("javaflag"), "-c -o /tmp/", filename, ".obj"}).c_str()); //Java语言
        return std::pair<std::string, std::string>("gcj", getenv("javaflag"));
    }else{
        throw std::runtime_error("错误：找不到匹配的文件类型。");
    }
}
bool source_code::new_file(std::string _filename){ 
    return !system(stringplus((std::initializer_list<std::string>){"scripts/md5sum.sh", _filename, filename}).c_str());
}
std::string source_code::getName(){
    return filename;
}