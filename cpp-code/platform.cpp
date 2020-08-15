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
#include "platform.hpp"
template <typename T> platform::platform(const T&){
    for(auto it = list.begin(); it != list.end(); it++){
        files.push_back(*it);
    }
}
void platform::all_compile(){
    try{
        for(auto it = files.begin(); it != files.end(); it++){
            last = it->auto_compile();
            objects = stringplus((std::initializer_list<std::string>){objects,stringplus((std::initializer_list<std::string>){"/tmp/", it->getName(), ".obj"})});
            
        }
    }catch(std::logic_error except){
        throw except;
    }
}
int platform::all_link(std::string target){
    return system(stringplus((std::initializer_list<std::string>){"ld", objects, "-lstdc++ -lm -o", target}).c_str());
}