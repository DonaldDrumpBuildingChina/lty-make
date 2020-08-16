# Auto-Compile By Liu Tianyou

一般来说，想要编译一个（单/多文件）项目，只需要运行以下的命令行：

```
# lty-make auto "main.cpp hello.cpp" "../hello.out"
```

判断项目类型（C或C++）是以最后一个项目的后缀名为准。

自动编译不会支持Python，因为Python没有编译器，不会生成目标文件。

如果想要修改默认的编译参数，请这样做：

```
# lty-make set cflag 'C编译参数'
# lty-make set cxxflag 'C++编译参数'
# lty-make set pasflag 'Pascal编译参数'
# lty-make set forflag 'Fortran编译参数'
```

如果你有一个文件夹的单文件项目，试试这个：

```
# lty-make dir "code" "../"
```

你甚至可以规定是否递归！试试这个：

```
# lty-make dir "code" "../" -r
```

新增加的功能：多编译器安装！

```
# lty-make install "require"
# lty-make remove "c++"
```

提示：这是实验性功能，编译器安装后会覆盖任何未安装的编译器，请谨慎使用。

由于C,C++,Fortran,Pascal的编译器都属于gcc的一部分，所以删除其中任何一个都会删除所有的gcc。

一个更稳妥的方式：
```
# lty-make install "gcc"
# lty-make remove "gcc"
```

试试改成`c`,`c++`,`fortran`,`pascal`,`bash`,`git`,`python`,`apache`,`php`,`mysql`,`nginx`!!!（注意，需要先安装依赖）

同时我们允许自动将一些未经修改的的项目保留，并支持更多语言！

欢迎提交工单/推送请求，注意命令行的顺序（不要颠倒）。

仓库作者授权任何人对代码进行任何操作。许可证：
```
            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
                    Version 2, December 2004

 Copyright (C) 2012 Romain Lespinasse <romain.lespinasse@gmail.com>

 Everyone is permitted to copy and distribute verbatim or modified
 copies of this license document, and changing it is allowed as long
 as the name is changed.

            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

  0. You just DO WHAT THE FUCK YOU WANT TO.
```