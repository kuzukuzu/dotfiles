#!/bin/sh
LIST=`ls -a`
DIR=`echo $(cd $(dirname $0);pwd)`

for i in $LIST
do
	case $i in
  '.'|'..'|'install.sh'|'.git'|'README.md')
    ;;
  *)
		ln -s ${DIR}/$i ~/$i
    ;;
	esac
done

