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
#include "header.hpp"
#include <cstdio>
#include <vector>
#include <iostream>
#include <string>
#define _CRT_SECURE_NO_WARNINGS
using namespace std;
string *argvs;
int main(int argc, char** argv){
    cout<<"lty-make 基于"<<GCC_V<<"和"<<MAKE_V<<"构建。"<<endl;
    try{
        argvs = new string [argc];
        for(int i = 0; i < argc; i++){
            argvs[i] = string(argv[i]);
        }
        if(argc == 3 && argvs[1] == "auto"){
            platform pf(forstring(argv[2]));
            pf.all_compile();
            pf.all_link(argvs[3]);
        }else if(argvs[1] == "dir"){
            auto compile = [](string name){
                source_code source(name);
                auto status = source.auto_compile();
                system(stringplus((std::initializer_list<std::string>){status.first, source.getName(),\
                status.second, "-o", argvs[3], "/", source.getsuffix()}).c_str());
            };
            if(argc == 3){
                dir(argvs[2],compile,false);
            }else if(argc == 4){
                dir(argvs[2],compile,true);
            }else{
                system("scripts/help.sh");
            }
        }else if(argc == 3 && argvs[1] == "set"){
            set(argvs[2].c_str(), argvs[3].c_str());
        }else if(argc == 2 && argvs[1] == "install"){
            system(stringplus((initializer_list<string>){"scripts/install.sh install", argvs[2]}).c_str());
        }else if(argc == 2 && argvs[1] == "remove"){
            system(stringplus((initializer_list<string>){"scripts/install.sh remove", argvs[2]}).c_str());
        }else{
            system("scripts/help.sh");
        }
    }catch(runtime_error x){
        cerr<<x.what()<<endl;
        return 1;
    }catch(...){
        cerr<<"未知错误！"<<endl;
        return 1;
    }
    cout<<"运行完毕。"<<endl;
    return 0;
}
/*
# Standrand ASCII keyboard
# ┌───┐   ┌───┬───┬───┬───┐ ┌───┬───┬───┬───┐ ┌───┬───┬───┬───┐ ┌───┬───┬───┐
# │Esc│   │ F1│ F2│ F3│ F4│ │ F5│ F6│ F7│ F8│ │ F9│F10│F11│F12│ │P/S│S L│P/B│  ┌┐    ┌┐    ┌┐
# └───┘   └───┴───┴───┴───┘ └───┴───┴───┴───┘ └───┴───┴───┴───┘ └───┴───┴───┘  └┘    └┘    └┘
# ┌───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───────┐ ┌───┬───┬───┐ ┌───┬───┬───┬───┐
# │~ `│! 1│@ 2│# 3│$ 4│% 5│^ 6│& 7│* 8│( 9│) 0│_ -│+ =│ BacSp │ │Ins│Hom│PUp│ │N L│ / │ * │ - │
# ├───┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─────┤ ├───┼───┼───┤ ├───┼───┼───┼───┤
# │ Tab │ Q │ W │ E │ R │ T │ Y │ U │ I │ O │ P │{ [│} ]│ | \ │ │Del│End│PDn│ │ 7 │ 8 │ 9 │   │
# ├─────┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴─────┤ └───┴───┴───┘ ├───┼───┼───┤ + │
# │ Caps │ A │ S │ D │ F │ G │ H │ J │ K │ L │: ;│" '│ Enter  │               │ 4 │ 5 │ 6 │   │
# ├──────┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴────────┤     ┌───┐     ├───┼───┼───┼───┤
# │ Shift  │ Z │ X │ C │ V │ B │ N │ M │< ,│> .│? /│  Shift   │     │ ↑ │     │ 1 │ 2 │ 3 │   │
# ├─────┬──┴─┬─┴──┬┴───┴───┴───┴───┴───┴──┬┴───┼───┴┬────┬────┤ ┌───┼───┼───┐ ├───┴───┼───┤ E││
# │ Ctrl│    │Alt │         Space         │ Alt│    │    │Ctrl│ │ ← │ ↓ │ → │ │   0   │ . │←─┘│
# └─────┴────┴────┴───────────────────────┴────┴────┴────┴────┘ └───┴───┴───┘ └───────┴───┴───┘
# So, don't press any keys wrong!
# And FUCK you, "dear" BUGS!

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
*/