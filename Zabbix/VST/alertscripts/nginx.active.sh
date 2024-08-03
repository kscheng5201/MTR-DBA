a=`sudo netstat -plan|awk {'print $4'}|grep :$1|grep -v 0.0.0.0|grep -v :::|grep -v :$1[0-9]|sort|uniq`
for a in "$a"
do
if [ -z "$a" ];then
        echo 0
	exit 0
else
        if [ -z "$b" ];then
                b=`sudo netstat -plan|grep -w $a|grep -v :$1[0-9]|awk {'print $5'}|cut -d: -f 1|sort -nk 1|grep -v 0.0.0.0|wc -l`
        else
                c=`sudo netstat -plan|grep -w $a|grep -v :$1[0-9]|awk {'print $5'}|cut -d: -f 1|sort -nk 1|grep -v 0.0.0.0|wc -l`
                ((b="$b"+"$c"))
        fi
fi
done
echo $b
