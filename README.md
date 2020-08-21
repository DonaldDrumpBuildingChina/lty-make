# Auto-Compile By Liu Tianyou

### 如何构建lty-make？

如果你是第一次使用，请使用这些：

```
sudo su root # 切换到root用户
make init && make && make install # 初始化，编译，安装
```

如果你已经成功构建过一次，请使用这些清除：

```
make clean && make init # 清理并初始化
```

这里还有别的工具：

```
make dist # 打包到../lty-make.tar.gz
```

### 如何使用lty-make？

一般来说，想要编译一个（单/多文件）项目，只需要运行以下的命令行：

```
lty-make auto "main.cpp hello.cpp" "../hello.out" # 将main.cpp hello.cpp作为一个项目编译为../hello.out
lty-make auto *.cpp a.out # 将目录下的所有cpp文件作为一个项目编译到a.out
```

如果想要修改默认的编译参数，请这样做：

```
lty-make set gccflag '编译参数' # 将被扩展为gcc (-c xxx) $gccflag -o xxx 
```
注意：目前支持GCC编译器支持的所有语言，并且支持多语言编译！

如果你有一个文件夹的单文件项目，试试这个：

```
lty-make dir "code" "../" # 表示将文件夹下的所有文件作为单文件项目输出
```

你甚至可以规定是否递归！试试这个：

```
lty-make dir "code" "../" -r # 递归遍历目录
```

新增加的功能：多编译器安装！

```
lty-make install "require" # 安装依赖
lty-make remove "gcc" # 移除gcc包
```

注意：编译器都是来自`gcc`，所以使用`gcc`代表所有编译器。

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

```
#                                      Legends never die!
#                                                               ...                                                                  
#                                                              .oocc.                                                                
#                                                             .c...ccc.                                                              
#                                                            .cc  ....coc                                                            
#                                                           .c.   ......co.                                                          
#                                                           .c.    .......oc.                                                        
#                                                           .c.   . ........co.                                                       
#                                                          cc   .  .......ccccc                                                      
#                                                          cc.     ......ccc.ccc.                                                    
#                                          ....           .cc....   ....ccccc.ccc.                                                   
#                                         .occczzc..      c....c...  ..ccccccc.ccc.                                                  
#                                         .cc....cozzc.  .o.....cc.....cccccccc..cu.                                                 
#                                         o........couuuzuccc.....c.cccccccccccc.cc.                                                
#                                     ....cc..........ccccccuooc......ccc.ccccc.ccccc.                                               
#                                     .zoouu.................ccocc....ccccccccccccc.co.                                              
#                   ..........c.......cc..ccc...............cc.ccoc...ccccccc.ccccc.ccc.                                             
#         ..cccccccccccccccccccccc...cuo...c.................c...cccc.cccccccccccccc..oc                                             
#   ..ccocc.....ccccc..............cozuc..c.....c.c.ccc.c...ccccc.ccccccccccccccccc.c.cc.                                            
# czc..        ..................cuhc.....  .cccccc......ccccccccccccccccccc.ccccccccc.cc.                                           
# .cc.          ....c.........ccuzc.        ..c....      .........ccccccccccccccc.ccc..cu.                                           
#  .cc........    .c.........couc                                  ..ccccccccccccc.c.cccc..                                          
#   cc..........   .........czc.                                      .cccccccccccccccc..cc                                          
#    cc........... .......cuz.                                          .ccccccc.cccccc..oc                                          
#    .cc. ........ccccc..czu.                                             .cccccccc.ccc..cc.   ..                                    
#    .cc.....ccccccccccczc.                   ...                          .ccccccccccc.c..  cccc.                                  
#       czccccccccccc.ccuo.          ..     ....                             .ccccccccccc..c..c. .cc.                                
#        czc.ccccccc.cczc.           ...  ....                                 cccccccccc..cuc..   cc.                               
#         cuoc.cccccccou.             ......                                    ccc.ccccc.cuc....   .cc                              
#          .cucccc..cuz.               ...                                      .ccccc.cc.cu. ...    .co.                            
#            cucc.cccuu.                .                                        .ccccc...co. ...   .  .c.                           
#             .cucccoo.                                      ..c.                 cccc.cccco.....       .cc.                         
#               .czuhc                                    .chhhhc                 .ccccccccc.....      ...cc.                        
#                 .uhc                                  .uhhhhc  ...              .ccccc..cc.....     .cc..cc.                       
#                   c.                                  chhhhzc   ohc             ..ccccc.cc. ...    .ccc...cc.                      
#                  ... .cc..                             chhzhhzcohhho             .cccc..cuc....   .ccccc...cc.                     
#                 .c. .chhhhhc.                         .chzzzhhhhhhhhc            .ccccc.couc..   .ccccccc...oc                     
#                 .u. ...cchhhhu.         ..cc..c.       chhzzuzzzuzzhh.          ..ccccc..uoccc...ccccccccc...cc                    
#                .c.  ...   ..cc.    ..cccoouoccuuo.     .hhzuzzzzzzzhh.          .ccccc..cooccoccccccc.cccc....oc.                  
#                cc    ..            .cuoocccccccoouc     chhhzzzzzzhhz.          .cccccc.cucccccccccccc.ccccc....co..               
#                cc                 .coccccccccccccuu.     chhhhhhhhhzc....      .ccccccccccccccccc.ccccccc.ccccc...ccc.             
#                cc                  ccccccccccccocooc.     .ohhhhhzc.....       .ccccc..coccccccccc.ccccccccccccccc..ccc.           
#                cc                  cccccccccccccc.cc.        ..........       ..ccccc..cucccccccccccccc.ccccc.ccccccc.coc          
#                .c.                 .cucccccc.......c.              .          .cccc..ccocccccccccccccccccc.ccccc.cccccozc.         
#                 .o.                 czocc..........c.                        .ccccc..cucccccccc.ccccccccccccc.cccccccoo.           
#                  .cc.               .ccc........ccc.                        .cccc...cucccccccccc.ccccccccccccccccccoc.             
#                    cuc.               ..ccccc.ccc.                  .cuoc. .cccc..czucccccccccccc.ccccccccccccccccc.               
#                     .cc..                ......      ..c.         .coocccucccc..cozzoccccccccccc.ccc.ccc.ccccccc.                  
#                      .ccc.                        .cc..z.      .cuc....czucc.ccc.  cuocccccc.ccc.ccccc.ccccc.                     
#                         .ccc.                    .c.  .c.   .cooc......coccccc.     .zucccccc.cccccc..ccc.                        
#                            .zhuc.                .c.    c...coc.........ozucc.        cuoc..cccccccc.ccc.                          
#                             .hhzuzucc.           ..     .cucc..........coc.            coccccccccc.ccc.                            
#                              .cuuc.  .ccc...    ..      coc...........cc.               .uccc.ccccoc.                              
#            .cuuccc..         .ccuc.      ....  ..     .cc............cu.                .coc.cccc.                                
#            .ccc.cccccouocc..   .cuzhuc.               ..cc..........ccc.                  .cccc.                                   
#           .cc............cccoccccc.cc.               .ccc.........c.cuc                   cococ                                    
#          .cc.......................              ...cccc.......cccccc.                   cocc.                                    
#            .cc...................c.           ....cccc.ccccc..cccc.cc.                   .coc.                                     
#             cuc................cc.        ...cccccc...cccccccccc..cc.          ..       .ccco.  .c.   ...                          
#             .ccc...............c.     ...ccccc........cccccccc...cc.   ..c.   .ccc. ... .oc.   cc.     .....                       
#             .coc.............c.   .ccccc.............ccccccc..cc.       .. .....   cc...cc...c.   ...   .cc.                      
#              coccc..............cccc...............ccc.ccc..czc          .cc.    .c. .cccc .    .c...                            
#                 .cucccc.........c...................ccc.ccccc.coc     ..c.      ....   .uc.     .cc   ...                          
#                   .cccccc...........................cccccccccccc.       ..    ...... ..coc     ...      ......                     
#                     ..ouc..........................ccccc.cc..cu.          ....c...  .chhu.  .............cc.c.                     
#                       .ccccc.......ccc.............ccccccccccc.         .c.. ...    .ozc.   . .cc..........                        
#                         cuccccccccc...............ccccccc.ccuc          cc.   .     .cz.      ...       ...                        
#                         .coc.cccc................cccccccccccc          .cc   ....ccccc.       .c..      .c.                        
#                           ccocc.................ccccccc.cccc.         ....   ..cczhoc..       .c..  .  ..c.                        
#                            cuc...................ccccc.cco.                  ..czuc.                                               
#                           cc...................ccccc..ccc.                 .cczzc.                                                 
#                         .cc...................cccc...cc.               ..cczhzc.                                                   
#                       .cc....................cc...cczzuc...........ccccchhhc..                                                     
#                       .hc..................ccccouzhzoooocccccccccouzhhzo..                                                         
#                       .cucc...........ccccccccc.    ....ccccococcc..                                                               
#                         .ooccccccccccccccoc.                                                                                       
#                          .ccccccccccc.. 
```
