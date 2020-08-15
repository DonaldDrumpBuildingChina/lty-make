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
template <typename T> std::string stringplus(const T &list){
    std::stringstream stream;
    for(auto it = list.begin(); it != list.end(); it++){
        stream << *it << ' ';
    }
    std::string temp;
    stream >> temp;
    return temp;
}
void set(std::string name, std::string value){
    setenv(name.c_str(), value.c_str(), 1);
}
void dir(std::string dir,std::string word, bool r, std::string advance){
    //TODO: by Liu Tianyou
}