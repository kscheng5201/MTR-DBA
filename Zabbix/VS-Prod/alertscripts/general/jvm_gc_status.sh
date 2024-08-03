#!/bin/bash

TargetWord='SocketPlatform.jar'
JavaBinDir='/bin/java'

PID=$("${JavaBinDir}"jps -l |grep ${TargetWord} | awk -F' ' '{print $1}')

flag=0
for i in $PID
do
    if [ ! -z $i  ]
    then
        let flag+=1
    fi
done

if [ $flag -ne 1 ]
then
    echo "the number of $TargetWord is more than 1 !!!"
    exit
fi

# get value from jstat
function gcstat_colum(){
    if [ ! -z ${1} ] && [ -z ${2} ]
    then
        ret=`"${JavaBinDir}"jstat -gccause $PID 1 1 |tail -1|awk -F' ' '{print $'${1}'}'`
        echo $ret
    elif [ ! -z ${1} ]&& [ ! -z ${2} ]
    then
        ret=`"${JavaBinDir}"jstat -gccause $PID 1 1 |tail -1|awk -F' ' '{print $'${1}',$'
${2}'}'`
        echo $ret
    else
        echo 'function get wrong arguments !'
    fi
}

# print prompt when script parameter is wrong
function print_prompt(){
    echo '    please input correct parameter !'
    echo '
    s1  (Survivor0)
    s2  (Survivor1)
    eden(Eden)
    old (Old)
    meta(Metaspace)
    css (CCS)
    ygc (YGC)
    ygct(YGCT)
    fgc (FGC)
    fgct(FGCT)
    gct (GCT)
	lgcc(LGCC)
    gcc (GCC)
'
}

# transfer script's parameter to function gcstat_colum()
case $1 in
s1)
    gcstat_colum 1
    ;;
s2)
    gcstat_colum 2
    ;;
eden)
    gcstat_colum 3
    ;;
old)
    gcstat_colum 4
    ;;
meta)
    gcstat_colum 5
    ;;
css)
    gcstat_colum 6
    ;;
ygc)
    gcstat_colum 7
    ;;
ygct)
    gcstat_colum 8
    ;;
fgc)
    gcstat_colum 9
    ;;
fgct)
    gcstat_colum 10
    ;;
gct)
    gcstat_colum 11
    ;;
lgcc)
    gcstat_colum 12 13
    ;;
gcc)
    gcstat_colum 14 15
    ;;
*)
    print_prompt
    ;;


esac
