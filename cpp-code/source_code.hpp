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
#include "functions.hpp"
//源代码类
class source_code
{
private:
    std::ifstream source; //源代码文件
    std::string filename, name, suffix; //文件名，前缀名，后缀名
public:
    source_code(std::string); //构造函数，用于打开一个文件
    std::pair<std::string, std::string> auto_compile(); //自动编译一个文件，返回编译器和命令行
    bool new_file(std::string); //检查文件是否为最新
    std::string getName();
    ~source_code(); //析构函数，用于关闭文件
};