# Auto-Compile By Liu Tianyou

一般来说，想要编译一个（单/多文件）项目，只需要运行以下的命令行：
```
lty-make.sh -auto "main.cpp hello.cpp" "../hello.out"
```
判断项目类型（C或C++）是以最后一个项目的后缀名为准。

如果你有一个文件夹的单文件项目，试试这个：
```
lty-make -dir-compile "code" "../" 
```

要使用老式编译，使用这个：
```
lty-make -compiler "g++" "-p -g -O3" "main.cpp hello.cpp" "-o"(output flag) "-c"(only compile flag) "../hello.out"
```

如果你想安装编译器，试试这个：
```
lty-make -install "g++"
```

想要修改自动编译的命令行，你需要改变环境变量$cflag和$cxxflag的值。

欢迎提交工单/推送请求。