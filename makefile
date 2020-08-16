.PHONY: install uninstall dist clean
lty-make: objects/functions.o objects/platform.o objects/source_code.o
	g++ objects/functions.o objects/platform.o objects/source_code.o -std=gnu++11 -Wall -o lty-make
	-mkdir /lty-make
	-mkdir /lty-make/download
	-mkdir /lty-make/package
objects/functions.o: functions/functions.hpp functions/functions.cpp
	g++ functions/functions.cpp -std=gnu++11 -Wall -c -o objects/functions.o
objects/platform.o: platform/platform.hpp platform/platform.cpp
	g++ platform/platform.cpp -std=gnu++11 -Wall -c -o objects/platform.o
objects/source_code.o: source_code/source_code.hpp source_code/source_code.cpp
	g++ source_code/source_code.cpp -std=gnu++11 -Wall -c -o objects/source_code.o
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