#!/bin/sh
LIST=`ls -a`
DIR=`echo $(cd $(dirname $0);pwd)`

for i in $LIST
do
	case $i in
  '.'|'..'|'install.sh'|'.git'|'.gitignore'|'.gitmodules'|'README.md')
    ;;
  *)
		ln -s ${DIR}/$i ~/$i
    ;;
	esac
done

git submodule init
git submodule update
