for connections in $(sudo netstat -nutlp |grep $1|awk '{print $7}'|sort|uniq|awk -F "/" '{print $1}'); do sudo ls -l /proc/$connections/fd 2>&1|grep socket|wc -l; done
