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
    if(new_file()){
        system(stringplus((std::initializer_list<std::string>{"gcc -c",filename, getenv("gccflag") ,"-o", object_name})).c_str());
    }
}
bool source_code::new_file(){ 
    struct stat source_time, object_time;
    FILE *source = fopen(filename.c_str(), "r"), *object = fopen(object_name.c_str(),"r");
    fstat(fileno(source),&source_time),fclose(source);
    fstat(fileno(object),&object_time),fclose(object);
    return source_time.st_mtim.tv_nsec>object_time.st_mtim.tv_nsec;
}
std::string source_code::getName(){
    return filename;
}
std::string source_code::getname(){
    return name;
}
std::string source_code::getsuffix(){
    return suffix;
}
std::string source_code::getObjectName(){
    return object_name;
}
