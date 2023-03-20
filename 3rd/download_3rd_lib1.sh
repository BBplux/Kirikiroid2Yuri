#!/usr/bin/bash

# update submodule 
git submodule init
git submodule update

# download other files
wget https://www.rarlab.com/rar/unrarsrc-6.1.7.tar.gz

tar xvf unrarsrc-6.1.7.tar.gz