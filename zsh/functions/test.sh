#!/bin/zsh

echo -n test

echo -en "\033[6n"
read -s -d R curpos
curpos=${curpos#*;}

echo ${curpos}
