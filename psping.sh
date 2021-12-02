#!/bin/bash -x
  
Main()
{
for ((c=0; c<${COUNTER}; c++))
do
ps aux | grep "${search}" | grep "${user}"
done
}

export -f Main

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

timeout ${mytimeout} bash -c Main

