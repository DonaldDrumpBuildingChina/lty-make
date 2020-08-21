######################################################################
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
######################################################################
flag = -std=c++17 -Wall -g -p -O3 -static -lpthread
.PHONY: install dist clean init install-require
lty-make: objects/functions.o objects/platform.o objects/source_code.o objects/main.o 
	g++ objects/*.o $(flag) -o ../lty-make
objects/functions.o: functions/functions.hpp functions/functions.cpp
	g++ -c functions/functions.cpp $(flag) -o objects/functions.o
objects/platform.o: platform/platform.hpp platform/platform.cpp
	g++ -c platform/platform.cpp $(flag) -o objects/platform.o
objects/source_code.o: source_code/source_code.hpp source_code/source_code.cpp
	g++ -c source_code/source_code.cpp $(flag) -o objects/source_code.o
objects/main.o: header.hpp make.hpp main.cpp
	g++ -c main.cpp $(flag) -o objects/main.o
install:
	-ln -s `pwd`/lty-make /usr/bin
	-ln -s `pwd`/scripts /usr/bin
dist:
	tar -czf ../lty-make.tar.gz .
init:
	@-mkdir /lty-make
	@-mkdir /lty-make/download
	@-mkdir /lty-make/package
	@-mkdir objects
	@echo "#pragma once" > make.hpp
	# @g++ -v 2> tmp
	# @echo "#define GCC_V \"`sed -n '9p' < tmp`\"" >> make.hpp 
	@make -v > tmp
	@echo "#define MAKE_V \"`head -n 1 tmp`\"" >> make.hpp
	@rm -rf tmp 
install-require: 
	command -v apt > /dev/null 2>&1 && { apt update -y; apt upgrade -y; apt install gcc make -y } || { yum update -y; apt install gcc make -y }
clean:
	-rm -rf objects
	-rm -rf lty-make
	-rm -rf /usr/bin/lty-make
	-rm -rf /usr/bin/scripts
	-rm -rf /lty-make
	-rm -rf ../lty-make
	-rm -rf gmon.out
