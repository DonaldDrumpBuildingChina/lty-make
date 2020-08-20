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
platform::platform(const std::vector<std::string> &list){
    for(auto it = list.begin(); it != list.end(); it++){
        files.push_back(*it);
    }
}
void platform::all_compile(){
    std::vector<std::thread*> threads;
    auto lambda = [this](auto it){
        this->last = it->auto_compile();
        this->objects = stringplus((std::initializer_list<std::string>)
        {objects,stringplus((std::initializer_list<std::string>){"/tmp/", it->getName(), ".obj"})});
    };
    for(auto it = files.begin(); it != files.end(); it++){
        std::thread* t = new std::thread(lambda,it);
        t->detach();
        threads.push_back(t);
    }
    for(auto it = threads.begin(); it != threads.end(); it++){
        (*it)->join();
    }    
}
int platform::all_link(std::string target){
    return system(stringplus((std::initializer_list<std::string>){"gcc", objects, getenv("gccflag"), "-o", target}).c_str());
}
