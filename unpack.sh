#!/bin/bash -x
set -e
# list of supported zip format and commands
pkg=("bzip2" "gzip" "unzip" "ncompress")
cmd=("gunzip" "bunzip2" "unzip" "uncompress")

# list of files to decompress
list=$(file *| grep compress | cut -d ":" -f1)
recurseList=$(find . -type f | xargs file | grep compressed | cut -d ":" -f1)
export $(cat /etc/os-release | grep ^ID=)

if [ $ID == \"centos\" ] ;
  then  yum install -y ${pkg[@]} > /dev/null 2>&1 ;
else
  apt-get install -y ${pkg[@]}> /dev/null 2>&1 ;
fi

if [ $# -eq 2 ]
 then
  for p in ${cmd[@]} ;
  do $p $recurseList ;
 done
  exit
fi

Main()
{
if [ $# -lt 1 ]
then
  for p in ${cmd[@]} ;
  do $p $list 2> /dev/null ;
done
  exit
fi
}

Recurse()
{
  for r in ${cmd[@]} ;
  do $r $recurseList 2> /dev/null ;
  done
}

Verbos()
{
  for r in ${cmd[@]} ;
  do $r $list ;
  done
}

Help()
{
   echo "The [unpack] command will extract all gunzip|bunzip2|unzip|ncompress in its way"
   echo "   Version 1.0.1   "
   echo "Syntax: unpack [-r|v|h]"
   echo "options:"
   echo "-r     Recurse into folders"
   echo "-v     Verbose mode."
   echo "-h     Print this Help."
   echo
}

while getopts rv:h flag
do
    case "${flag}" in
        r) Recurse
	   ;;
        v) Verbos
	   ;;
        h) Help
           exit  
	   ;;
	*) Main
	   ;;
    esac
done
