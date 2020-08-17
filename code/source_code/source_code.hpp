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
#pragma once
#include <fstream>
#include <string>
#include <exception>
#include <initializer_list>
#include <map>
#include "functions.hpp"
//源代码类
class source_code{
private:
    std::map<std::string, std::pair<std::string, std::string>> compilers;
    std::string filename, name, suffix;
public:
    source_code(std::string);
    std::pair<std::string, std::string> auto_compile();
    bool new_file(std::string);
    std::string getName();
    std::string getname();
    std::string getsuffix();
};