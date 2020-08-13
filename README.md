# Auto-Compile By Liu Tianyou

For example, $0 -auto "main.cpp hello.cpp" "../hello.out"

Or try this, $0 -dir-compile "code" "../" 

If you want chooice a compiler, try this, $0 -compiler "g++" "-p -g -O3" "main.cpp hello.cpp" "-o"(output flag) "-c"(only compile flag) "../hello.out"

If you want to install compiler, use $0 -install "g++"

If you want to chooise flags, you need to change env $cflag $cxxflag (TODO: more languages)

If compile error, script will exit.

So if you get a error, please send a e-mail to my email [1347277058@qq.com](mailto://1347277058@qq.com).