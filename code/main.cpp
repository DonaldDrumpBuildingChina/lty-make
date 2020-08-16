#include "header.hpp"
#include <cstdio>
#include <vector>
#include <iostream>
#define _CRT_SECURE_NO_WARNINGS
using namespace std;
int main(int argc, char** argv){
    try{
        string *argvs = new string [argc];
        for(int i = 0; i < argc; i++){
            argvs[i] = string(argv[i]);
        }
        if(argc == 3 && argvs[1] == "auto"){
            platform pf(forstring(argv[2]));
            pf.all_compile();
            pf.all_link(argvs[3]);
        }else if(argvs[1] == "dir"){
            auto compile = [](string name){};
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
    return 0;
}