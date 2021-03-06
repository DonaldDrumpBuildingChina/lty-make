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
#include <initializer_list>
#include <sstream>
#include <string>
#include <vector>
#include <dirent.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>
#include <thread>
#include <iostream>
#include <map>

#define system mysystem

template <typename T> std::string stringplus(const T&, bool = true);
void set(std::string, std::string);
void dir(std::string, void (*)(std::string), bool, int = 0);
std::vector<std::string> forstring(std::string);
void help(void);
void package(bool, std::string);
int mysystem(std::string, std::string = "",  bool = true, bool = false);
template <typename T> std::string tostring(const T&);

