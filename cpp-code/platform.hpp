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
#include "source_code.hpp"
#include "functions.hpp"
#include <vector>
#include <string>
class platform{ //项目类
private:
    std::vector<source_code> files; //项目文件列表
    std::string objects; //目标文件列表
    std::pair<std::string, std::string> last;
public:
    template <typename T> platform(const T&); //构造函数
    void all_compile(); //全部编译
    int all_link(std::string); //全部链接
};