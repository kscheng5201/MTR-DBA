a=`sudo netstat -plan|awk {'print $4'}|grep :$1|grep -v 0.0.0.0|grep -v :::
for a in "$a"
do
if [ -z "$a" ];then
        echo 0
	exit 0
else
        if [ -z "$b" ];then
                b=`sudo netstat -plan|grep -w $a|grep -v :$1[0-9]|awk {'pri
        else
                c=`sudo netstat -plan|grep -w $a|grep -v :$1[0-9]|awk {'pri
                ((b="$b"+"$c"))
        fi
fi
done
echo $b
