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
#include "source_code/source_code.hpp" 
#include "platform/platform.hpp"
#include "functions/functions.hpp"
#include "make.hpp"
#include <cstdio>
#include <vector>
#include <iostream>
#include <string>
#include <signal.h>

#ifndef __linux__
#error "编译错误！请在Linux平台编译！"
#endif