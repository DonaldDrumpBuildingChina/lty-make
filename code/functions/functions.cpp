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
#include "functions.hpp"
template <typename T> std::string stringplus(const T& list){
    std::stringstream stream;
    for (auto it = list.begin(); it != list.end(); it++) {
        stream << *it << ' ';
    }
    std::string temp;
    stream >> temp;
    return temp;
}
void set(std::string name, std::string value){
    setenv(name.c_str(), value.c_str(), 1);
}
void dir(std::string _dir, void (*word)(std::string), bool r){
    DIR* p_dir = NULL;
    struct dirent* p_entry = NULL;
    struct stat statbuf;
    if ((p_dir = opendir(_dir.c_str())) == NULL) return;
    chdir(_dir.c_str());
    while (NULL != (p_entry = readdir(p_dir))) {
        lstat(p_entry->d_name, &statbuf);
        if (S_IFDIR & statbuf.st_mode) {
            if (std::string(p_entry->d_name) == "." || std::string(p_entry->d_name) == "..")
                continue;
            dir(p_entry->d_name, word, r);
        } else {
            word(p_entry->d_name);
        }
    }
    chdir("..");
    closedir(p_dir);
}
std::vector<std::string> forstring(std::string str){
    std::string temp;
    temp.resize(100);
    std::vector<std::string> files;
    while(sscanf(str.c_str(),"%s",&temp[0])){
        files.push_back(temp);
    }
    return files;
}