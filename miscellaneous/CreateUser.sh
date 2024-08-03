#!/bin/bash                                                                                                            
#######################################
# Project: 大量建立 MySQL 帳號
# Branch: 
# Author: Gok' 'the DBA
# Created: 2022-11-16
# Updated: 2022-11-16
# Note: 世界盃期間的帳號
#######################################

#### 名單 ##############################
## NLD #################################
# Victor, William, Gary, Sean  
# Neo, Rick, Dexter, Sheldon 
# Oneal, nld_Andy, Jack, Stan,Alan
## VS,DM ###############################
# Mick,Rain,Hardy,Marco,Andy,Emma,Scott
########################################


users=('Victor' 'William' 'Gary' 'Sean' 
'Neo' 'Rick' 'Dexter' 'Sheldon'
'Oneal' 'nld_Andy' 'Jack' 'Stan' 'Alan'
'Mick' 'Rain' 'Hardy' 'Marco' 'Andy' 'Emma' 'Scott')

jumper='10.23.3.197'
# jumper='10.23.3.199'

for user in ${users[@]}
do
    echo 
    echo making $user

    password=`tr -dc A-Za-z0-9_ < /dev/urandom | head -c 16 | xargs`
    echo "DROP USER IF EXISTS $user@$jumper;" >> create_user.sql
    echo CREATE USER ${user}@$jumper IDENTIFIED BY \"~$password\"';' >> create_user.sql
    echo 'flush privileges; flush logs;' >> create_user.sql
done


# DROP USER IF EXISTS Victor@10.23.3.197;
# CREATE USER Victor@10.23.3.197 IDENTIFIED BY "~JwY_TftjSaJccSI0";
# flush privileges; flush logs;
# DROP USER IF EXISTS William@10.23.3.197;
# CREATE USER William@10.23.3.197 IDENTIFIED BY "~FIH5oWzEiAFS2JRF";
# flush privileges; flush logs;
# DROP USER IF EXISTS Gary@10.23.3.197;
# CREATE USER Gary@10.23.3.197 IDENTIFIED BY "~ps5NsmK52YvUqrnA";
# flush privileges; flush logs;
# DROP USER IF EXISTS Sean@10.23.3.197;
# CREATE USER Sean@10.23.3.197 IDENTIFIED BY "~MwkHPZhJhQjsIi1R";
# flush privileges; flush logs;
# DROP USER IF EXISTS Neo@10.23.3.197;
# CREATE USER Neo@10.23.3.197 IDENTIFIED BY "~ZBot2TEk51WdqtbR";
# flush privileges; flush logs;
# DROP USER IF EXISTS Rick@10.23.3.197;
# CREATE USER Rick@10.23.3.197 IDENTIFIED BY "~IuX9jfC014v468hr";
# flush privileges; flush logs;
# DROP USER IF EXISTS Dexter@10.23.3.197;
# CREATE USER Dexter@10.23.3.197 IDENTIFIED BY "~Iy1hmvVuz7GHJycB";
# flush privileges; flush logs;
# DROP USER IF EXISTS Sheldon@10.23.3.197;
# CREATE USER Sheldon@10.23.3.197 IDENTIFIED BY "~agwH6VHEnsEs6UnN";
# flush privileges; flush logs;
# DROP USER IF EXISTS Oneal@10.23.3.197;
# CREATE USER Oneal@10.23.3.197 IDENTIFIED BY "~C03uAt8KRXQO7XUH";
# flush privileges; flush logs;
# DROP USER IF EXISTS nld_Andy@10.23.3.197;
# CREATE USER nld_Andy@10.23.3.197 IDENTIFIED BY "~eLsg8FhfeuIbfhHH";
# flush privileges; flush logs;
# DROP USER IF EXISTS Jack@10.23.3.197;
# CREATE USER Jack@10.23.3.197 IDENTIFIED BY "~nQNEzIkUN9vYkm93";
# flush privileges; flush logs;
# DROP USER IF EXISTS Stan@10.23.3.197;
# CREATE USER Stan@10.23.3.197 IDENTIFIED BY "~Di0OlVqrNOwIYVlz";
# flush privileges; flush logs;
# DROP USER IF EXISTS Alan@10.23.3.197;
# CREATE USER Alan@10.23.3.197 IDENTIFIED BY "~C_bo4pQj8FKhZhuV";
# flush privileges; flush logs;
# DROP USER IF EXISTS Mick@10.23.3.197;
# CREATE USER Mick@10.23.3.197 IDENTIFIED BY "~09oHaLNuKRK0bx0J";
# flush privileges; flush logs;
# DROP USER IF EXISTS Rain@10.23.3.197;
# CREATE USER Rain@10.23.3.197 IDENTIFIED BY "~FLHr8pdUEXuel2Zn";
# flush privileges; flush logs;
# DROP USER IF EXISTS Hardy@10.23.3.197;
# CREATE USER Hardy@10.23.3.197 IDENTIFIED BY "~yLZDk7BdnwEZQEei";
# flush privileges; flush logs;
# DROP USER IF EXISTS Marco@10.23.3.197;
# CREATE USER Marco@10.23.3.197 IDENTIFIED BY "~Bzo1nncvZoao8yHn";
# flush privileges; flush logs;
# DROP USER IF EXISTS Andy@10.23.3.197;
# CREATE USER Andy@10.23.3.197 IDENTIFIED BY "~bVxKqbQ0vDaaerv3";
# flush privileges; flush logs;
# DROP USER IF EXISTS Emma@10.23.3.197;
# CREATE USER Emma@10.23.3.197 IDENTIFIED BY "~TWU3wJy3cbbghcbO";
# flush privileges; flush logs;
# DROP USER IF EXISTS Scott@10.23.3.197;
# CREATE USER Scott@10.23.3.197 IDENTIFIED BY "~k8EYkcZ9pVXhBjQw";
# flush privileges; flush logs;
