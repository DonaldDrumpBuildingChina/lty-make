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
#include "../source_code/source_code.hpp"
#include "../functions/functions.hpp"
#include <vector>
#include <string>
class platform{
private:
    std::vector<source_code> files;
    std::string objects;
    std::pair<std::string, std::string> last;
public:
    template <typename T> platform(const T&);
    std::pair<std::string, std::string> all_compile();
    int all_link(std::string);
};