#!/bin/sh
LIST=`ls -a`
DIR=`echo $(cd $(dirname $0);pwd)`

for i in $LIST
do
	case $i in
  '.'|'..'|'install.sh'|'.git')
    ;;
  *)
		ln -s ${DIR}/$i ~/$i
    ;;
	esac
done

