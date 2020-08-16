.PHONY: install uninstall dist clean
lty-make: objects/functions.o objects/platform.o objects/source_code.o
	-mkdir /lty-make
	-mkdir /lty-make/download
	-mkdir /lty-make/package
	echo "#pragma once" > make.hpp
	g++ -v > tmp
	echo "#define GPP_V `head -n 9 tmp`" >> make.hpp 
	make -v > tmp
	echo "#define MAKE_V `head -n 1 tmp`" >> make.hpp
	rm -rf tmp 
	g++ objects/functions.o objects/platform.o objects/source_code.o -std=gnu++11 -Wall -g -p -o lty-make
objects/functions.o: functions/functions.hpp functions/functions.cpp
	g++ functions/functions.cpp -std=gnu++11 -Wall -g -p -c -o objects/functions.o
objects/platform.o: platform/platform.hpp platform/platform.cpp
	g++ platform/platform.cpp -std=gnu++11 -Wall -g -p -c -o objects/platform.o
objects/source_code.o: source_code/source_code.hpp source_code/source_code.cpp
	g++ source_code/source_code.cpp -std=gnu++11 -Wall -g -p -c -o objects/source_code.o
install:
	-ln -s `pwd`/lty-make /usr/bin
	-ln -s `pwd`/scripts /usr/bin
uninstall:
	-rm -rf /usr/bin/lty-make
	-rm -rf /usr/bin/scripts
dist:
	tar -czf ../lty-make.tar.gz .
clean:
	-rm -rf objects/*
	-rm -rf lty-make