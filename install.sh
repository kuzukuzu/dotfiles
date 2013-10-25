#!/bin/sh
LIST=`ls -a`
DIR=`echo $(cd $(dirname $0);pwd)`

for i in $LIST
do
	if test $i != '.' -a $i != '..' -a $i != 'install.sh'
	then
		ln -s ${DIR}/$i ~/$i
	fi
done

