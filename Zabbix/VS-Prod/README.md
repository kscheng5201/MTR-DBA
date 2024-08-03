# VS PROD
# 1. 說明
本playbook 共將vs-prod 的主機分為如下四類，
- 第一層主機(level1)
- 第二層主機(level2)
- 源站一般主機(general)
- 源站資料庫主機(db)
- 探點機(probe)

playbook名稱為sync-zabbix-script.yml，位於/etc/ansible/playbook/下。使用的role名稱為sync-zabbix-script，位於/etc/ansible/roles/下。
sync-zabbix-script.yml只會將各主機相對映的script & conf 檔拷到遠端主機的/etc/zabbix/alertscripts & /etc/zabbix/zabbix_agentd.d下，並不會修改遠端主機/etc/zabbix/zabbix_agentd.conf或是任何檔案，所以理論上同步後並不會影響現行Zabbix的運作。  

_**(同步後有可能script的數目會增加，但因為多出來的script並沒有被zabbix所使用，所以沒有關係)**_

# 2. 同步檔案到遠端主機. 
在執行playbook 前你要先決定你的遠端主機的IP或群組，並知道該主機是哪個分類。指令看起來是這個樣子的，  

`ansible-playbook /etc/ansible/playbook/sync-zabbix-script.yml -e hosts=IPs -t [level1|level2|general|db|probe]`. 

IPs可以是一個IP或是多個IP以",” 分隔，也可以是在inventory 裡定義的群組名。-t 參數後面接的是主機的分類，主機的分類可參考說明段落。

## 2.1 
假設要同步的主機為第一層主機pa-hk-f-f-n125，IP為47.57.183.125，則指令如下所示：

`ansible-playbook /etc/ansible/playbook/sync-zabbix-script.yml -e hosts=47.57.183.125 -t level1`

## 2.2 
假設要同步的主機為第二層主機pg-jp-m-b-n7，IP為35.221.109.7，則指令如下所示：

`ansible-playbook /etc/ansible/playbook/sync-zabbix-script.yml -e hosts=35.221.109.7 -t level2`

## 2.3 
假設要同步的主機為源站一般主機PROD-Logstash-sys-01，IP為10.23.1.160，則指令如下所示：

`ansible-playbook /etc/ansible/playbook/sync-zabbix-script.yml -e hosts=10.23.1.160 -t general`

## 2.4 
假設要同步的主機為源站資料庫主機PROD-RabbitMQ-01到03，IP為10.23.1.151~153，則指令如下所示：

`ansible-playbook /etc/ansible/playbook/sync-zabbix-script.yml -e hosts=10.23.1.151,10.23.1.152,10.23.1.153 -t db`. 

_check_mysql.sh_, check_mysql2.sh_ 這二個script 因在相關mysql 主機上的檔案名及內容都不同，所以如果同步的主機有mysql 要監控，請再自行參考設定檔調整檔案名稱及內容。_

# 3. 新增zabbix UserParameter
當你要新增了一個新的zabbix UserParameter 時，請將conf 檔案加在git 的zabbix_agentd.d 下，否則同步到遠端主機後不會生效。

