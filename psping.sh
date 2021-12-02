#!/bin/bash
set -e

Main()
{
for (( c=1; c<=$COUNTER; c++ ))
do
ps aux | grep "${search}" | grep "${user}"
done
}


while getopts :c:t:p:u: opt
do
  case ${opt} in
     c) COUNTER=${OPTARG}
     ;;
     t) mytimeout=${OPTARG}
     ;;
     p) search=${OPTARG}
     ;;
     u) user=${OPTARG}
     ;;
     *) Main
     ;;
     \? ) echo "Usage: ./psping.sh [-c] countPings [-t] alternateTimeOut [-p] processName [-u] userName"
     ;;
  esac
done

Main
