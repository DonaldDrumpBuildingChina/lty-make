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
.PHONY: install uninstall dist clean
lty-make: objects/functions.o objects/platform.o objects/source_code.o objects/main.o init
	g++ objects/functions.o objects/platform.o objects/source_code.o objects/main.o -std=c++11 -Wall -g -p -o ../lty-make
objects/functions.o: functions/functions.hpp functions/functions.cpp
	g++ -c functions/functions.cpp -std=c++11 -Wall -g -p -o objects/functions.o
objects/platform.o: platform/platform.hpp platform/platform.cpp
	g++ -c platform/platform.cpp -std=c++11 -Wall -g -p -o objects/platform.o
objects/source_code.o: source_code/source_code.hpp source_code/source_code.cpp
	g++ -c source_code/source_code.cpp -std=c++11 -Wall -g -p -o objects/source_code.o
objects/main.o: header.hpp main.cpp
	g++ -c main.cpp -std=c++11 -Wall -g -p -o objects/main.o
install:
	-ln -s `pwd`/lty-make /usr/bin
	-ln -s `pwd`/scripts /usr/bin
uninstall: clean
	-rm -rf /usr/bin/lty-make
	-rm -rf /usr/bin/scripts
dist:
	tar -czf ../lty-make.tar.gz .
init:
	@-mkdir /lty-make
	@-mkdir /lty-make/download
	@-mkdir /lty-make/package
	@echo "#pragma once" > make.hpp
	@g++ -v 2> tmp
	@echo "#define GCC_V \"`sed -n '9p' < tmp`\"" >> make.hpp 
	@make -v > tmp
	@echo "#define MAKE_V \"`head -n 1 tmp`\"" >> make.hpp
	@rm -rf tmp 
	@-touch init
clean:
	-rm -rf objects
	-rm -rf lty-make
	-rm -f init