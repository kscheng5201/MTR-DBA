--b-nacos-rds
mysql -h b-nacos-rds.ckryklccvkik.ap-northeast-1.rds.amazonaws.com -P 3306 -uburokkori -pSr8dcs\(pcX^TDn9fs+F^D
--===== 建帳號用 =====
CREATE USER 'root'@'%'           IDENTIFIED BY 'kC6&^kTNwia9^J5dyVaV';
CREATE USER 'app_use'@'10.0.%'   IDENTIFIED BY 'pR0^kckU9N$7Ilq8m5dN';
CREATE USER 'read.only'@'10.0.%' IDENTIFIED BY 'fH0^rJ4Ui7F5IhO4qEt&';
--===== 建帳號權限 =====
GRANT ALL PRIVILEGES ON *.* TO 'user'@'localhost';

GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, RELOAD, PROCESS, REFERENCES, INDEX, ALTER, SHOW DATABASES, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, REPLICATION SLAVE, REPLICATION CLIENT, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, CREATE USER, EVENT, TRIGGER, CREATE ROLE, DROP ROLE ON *.* TO 'root'@'%' WITH GRANT OPTION;
GRANT APPLICATION_PASSWORD_ADMIN,BACKUP_ADMIN,FLUSH_OPTIMIZER_COSTS,FLUSH_STATUS,FLUSH_TABLES,FLUSH_USER_RESOURCES,INNODB_REDO_LOG_ARCHIVE,PASSWORDLESS_USER_ADMIN,SHOW_ROUTINE ON *.* TO 'root'@'%' WITH GRANT OPTION;

GRANT PROCESS, REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'app_use'@'10.0.%';
GRANT XA_RECOVER_ADMIN ON *.* TO 'app_use'@'10.0.%';
GRANT ALL PRIVILEGES ON `nacos`.* TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`func` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`general_log` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`help_category` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`help_keyword` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`help_relation` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`help_topic` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`slow_log` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`time_zone_leap_second` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`time_zone_name` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`time_zone_transition_type` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`time_zone_transition` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`time_zone` TO 'app_use'@'10.0.%';

GRANT PROCESS ON *.* TO 'read.only'@'10.0.%';
GRANT SELECT, LOCK TABLES ON `nacos`.* TO 'read.only'@'10.0.%';
--===== 權限設定重新讀取 =====
FLUSH PRIVILEGES;


--b-rds57
mysql -h b-rds57.ckryklccvkik.ap-northeast-1.rds.amazonaws.com -P 3306 -uburokkori -pB9cfY$mZMxG)41KN%66o
--===== 建帳號用 =====
CREATE USER 'root'@'%'           IDENTIFIED BY 'bZ5^oih&ejcqRYmmg^63';
CREATE USER 'app_use'@'10.0.%'   IDENTIFIED BY 'eM4$5HufDotPHUeYrbPc';
CREATE USER 'read.only'@'10.0.%' IDENTIFIED BY 'fH0^rJ4Ui7F5IhO4qEt&';
--===== 建帳號權限 =====
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, RELOAD, PROCESS, REFERENCES, INDEX, ALTER, SHOW DATABASES, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, REPLICATION SLAVE, REPLICATION CLIENT, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, CREATE USER, EVENT, TRIGGER, CREATE ROLE, DROP ROLE ON *.* TO 'root'@'%' WITH GRANT OPTION;
GRANT APPLICATION_PASSWORD_ADMIN,BACKUP_ADMIN,FLUSH_OPTIMIZER_COSTS,FLUSH_STATUS,FLUSH_TABLES,FLUSH_USER_RESOURCES,INNODB_REDO_LOG_ARCHIVE,PASSWORDLESS_USER_ADMIN,SHOW_ROUTINE ON *.* TO 'root'@'%' WITH GRANT OPTION;

GRANT PROCESS, REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'app_use'@'10.0.%';
GRANT ALL PRIVILEGES ON `nacos`.* TO 'app_use'@'10.0.%';
GRANT ALL PRIVILEGES ON `spider`.* TO 'app_use'@'10.0.%';
GRANT ALL PRIVILEGES ON `box\_match`.* TO 'app_use'@'10.0.%';
GRANT ALL PRIVILEGES ON `import\_data`.* TO 'app_use'@'10.0.%';
GRANT ALL PRIVILEGES ON `saas\_admin`.* TO 'app_use'@'10.0.%';
GRANT ALL PRIVILEGES ON `saas\_catalina`.* TO 'app_use'@'10.0.%';
GRANT ALL PRIVILEGES ON `saas\_cockpit`.* TO 'app_use'@'10.0.%';
GRANT ALL PRIVILEGES ON `saas\_dark`.* TO 'app_use'@'10.0.%';
GRANT ALL PRIVILEGES ON `saas\_game`.* TO 'app_use'@'10.0.%';
GRANT ALL PRIVILEGES ON `saas\_gift`.* TO 'app_use'@'10.0.%';
GRANT ALL PRIVILEGES ON `saas\_guess`.* TO 'app_use'@'10.0.%';
GRANT ALL PRIVILEGES ON `saas\_information`.* TO 'app_use'@'10.0.%';
GRANT ALL PRIVILEGES ON `saas\_leaf`.* TO 'app_use'@'10.0.%';
GRANT ALL PRIVILEGES ON `saas\_live`.* TO 'app_use'@'10.0.%';
GRANT ALL PRIVILEGES ON `saas\_match`.* TO 'app_use'@'10.0.%';
GRANT ALL PRIVILEGES ON `saas\_merchant`.* TO 'app_use'@'10.0.%';
GRANT ALL PRIVILEGES ON `saas\_payment`.* TO 'app_use'@'10.0.%';
GRANT ALL PRIVILEGES ON `saas\_robot`.* TO 'app_use'@'10.0.%';
GRANT ALL PRIVILEGES ON `saas\_sms`.* TO 'app_use'@'10.0.%';
GRANT ALL PRIVILEGES ON `saas\_sns`.* TO 'app_use'@'10.0.%';
GRANT ALL PRIVILEGES ON `saas\_stargate`.* TO 'app_use'@'10.0.%';
GRANT ALL PRIVILEGES ON `saas\_tactic`.* TO 'app_use'@'10.0.%';
GRANT ALL PRIVILEGES ON `saas\_trade`.* TO 'app_use'@'10.0.%';
GRANT ALL PRIVILEGES ON `saas\_user`.* TO 'app_use'@'10.0.%';
GRANT ALL PRIVILEGES ON `saas\_voice`.* TO 'app_use'@'10.0.%';
GRANT ALL PRIVILEGES ON `yy\_sport`.* TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`func` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`general_log` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`help_category` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`help_keyword` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`help_relation` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`help_topic` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`slow_log` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`time_zone_leap_second` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`time_zone_name` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`time_zone_transition_type` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`time_zone_transition` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`time_zone` TO 'app_use'@'10.0.%';

GRANT PROCESS ON *.* TO 'read.only'@'10.0.%';
GRANT SELECT, LOCK TABLES ON `spider`.* TO 'read.only'@'10.0.%';
GRANT SELECT, LOCK TABLES ON `saas_admin`.* TO 'read.only'@'10.0.%';
GRANT SELECT, LOCK TABLES ON `saas_catalina`.* TO 'read.only'@'10.0.%';
GRANT SELECT, LOCK TABLES ON `saas_cockpit`.* TO 'read.only'@'10.0.%';
GRANT SELECT, LOCK TABLES ON `saas_gift`.* TO 'read.only'@'10.0.%';
GRANT SELECT, LOCK TABLES ON `saas_guess`.* TO 'read.only'@'10.0.%';
GRANT SELECT, LOCK TABLES ON `saas_leaf`.* TO 'read.only'@'10.0.%';
GRANT SELECT, LOCK TABLES ON `saas_live`.* TO 'read.only'@'10.0.%';
GRANT SELECT, LOCK TABLES ON `saas_match`.* TO 'read.only'@'10.0.%';
GRANT SELECT, LOCK TABLES ON `saas_merchant`.* TO 'read.only'@'10.0.%';
GRANT SELECT, LOCK TABLES ON `saas_payment`.* TO 'read.only'@'10.0.%';
GRANT SELECT, LOCK TABLES ON `saas_robot`.* TO 'read.only'@'10.0.%';
GRANT SELECT, LOCK TABLES ON `saas_sms`.* TO 'read.only'@'10.0.%';
GRANT SELECT, LOCK TABLES ON `saas_stargate`.* TO 'read.only'@'10.0.%';
GRANT SELECT, LOCK TABLES ON `saas_tactic`.* TO 'read.only'@'10.0.%';
GRANT SELECT, LOCK TABLES ON `saas_trade`.* TO 'read.only'@'10.0.%';
GRANT SELECT, LOCK TABLES ON `saas_voice`.* TO 'read.only'@'10.0.%';
GRANT SELECT, LOCK TABLES ON `yy_sport`.* TO 'read.only'@'10.0.%';
--===== 權限設定重新讀取 =====
FLUSH PRIVILEGES;


--b-rds57-box-match
mysql -h b-rds57-box-match.ckryklccvkik.ap-northeast-1.rds.amazonaws.com -P 3306 -uburokkori -pAuQNYACr%qs5*071g0rQ
--===== 建帳號用 =====
CREATE USER 'root'@'%'           IDENTIFIED BY 'tR3&YDis^^6sqVv4ps^t';
CREATE USER 'app_use'@'10.0.%'   IDENTIFIED BY 'nK5$RTr&VBw5IPQHXhn!';
CREATE USER 'read.only'@'10.0.%' IDENTIFIED BY 'fH0^rJ4Ui7F5IhO4qEt&';
--===== 建帳號權限 =====
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, RELOAD, PROCESS, REFERENCES, INDEX, ALTER, SHOW DATABASES, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, REPLICATION SLAVE, REPLICATION CLIENT, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, CREATE USER, EVENT, TRIGGER, CREATE ROLE, DROP ROLE ON *.* TO 'root'@'%' WITH GRANT OPTION;
GRANT APPLICATION_PASSWORD_ADMIN,BACKUP_ADMIN,FLUSH_OPTIMIZER_COSTS,FLUSH_STATUS,FLUSH_TABLES,FLUSH_USER_RESOURCES,INNODB_REDO_LOG_ARCHIVE,PASSWORDLESS_USER_ADMIN,SHOW_ROUTINE ON *.* TO 'root'@'%' WITH GRANT OPTION;

GRANT PROCESS, REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'app_use'@'10.0.%';
GRANT ALL PRIVILEGES ON `box\_match`.* TO 'app_use'@'10.0.%';
GRANT ALL PRIVILEGES ON `saas\_match`.* TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`func` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`general_log` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`help_category` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`help_keyword` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`help_relation` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`help_topic` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`slow_log` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`time_zone_leap_second` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`time_zone_name` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`time_zone_transition_type` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`time_zone_transition` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`time_zone` TO 'app_use'@'10.0.%';

GRANT PROCESS ON *.* TO 'read.only'@'10.0.%';
GRANT SELECT, LOCK TABLES ON `box_match`.* TO 'read.only'@'10.0.%';
--===== 權限設定重新讀取 =====
FLUSH PRIVILEGES;


--b-rds57-dark
mysql -h b-rds57-dark.ckryklccvkik.ap-northeast-1.rds.amazonaws.com -P 3306 -uburokkori -ppb*AqVpx5TFbpS1z5iT$
--===== 建帳號用 =====
CREATE USER 'root'@'%'           IDENTIFIED BY 'fB1&RAK*%NYwHo0h84OE';
CREATE USER 'app_use'@'10.0.%'   IDENTIFIED BY 'lU6%jI0PZnVPiXF$r7&T';
CREATE USER 'read.only'@'10.0.%' IDENTIFIED BY 'fH0^rJ4Ui7F5IhO4qEt&';
--===== 建帳號權限 =====
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, RELOAD, PROCESS, REFERENCES, INDEX, ALTER, SHOW DATABASES, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, REPLICATION SLAVE, REPLICATION CLIENT, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, CREATE USER, EVENT, TRIGGER, CREATE ROLE, DROP ROLE ON *.* TO 'root'@'%' WITH GRANT OPTION;
GRANT APPLICATION_PASSWORD_ADMIN,BACKUP_ADMIN,FLUSH_OPTIMIZER_COSTS,FLUSH_STATUS,FLUSH_TABLES,FLUSH_USER_RESOURCES,INNODB_REDO_LOG_ARCHIVE,PASSWORDLESS_USER_ADMIN,SHOW_ROUTINE ON *.* TO 'root'@'%' WITH GRANT OPTION;

GRANT PROCESS, REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'app_use'@'10.0.%';
GRANT ALL PRIVILEGES ON `saas\_dark`.* TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`func` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`general_log` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`help_category` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`help_keyword` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`help_relation` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`help_topic` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`slow_log` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`time_zone_leap_second` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`time_zone_name` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`time_zone_transition_type` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`time_zone_transition` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`time_zone` TO 'app_use'@'10.0.%';

GRANT PROCESS ON *.* TO 'read.only'@'10.0.%';
GRANT SELECT, LOCK TABLES ON `saas_dark`.* TO 'read.only'@'10.0.%';
--===== 權限設定重新讀取 =====
FLUSH PRIVILEGES;


--b-rds57-game
mysql -h b-rds57-game.ckryklccvkik.ap-northeast-1.rds.amazonaws.com -P 3306 -uburokkori -pNNVXqJP&0eqNC4fB%U91
--===== 建帳號用 =====
CREATE USER 'root'@'%'           IDENTIFIED BY 'uQ5&fTb%MTHwLrKB&FQI';
CREATE USER 'app_use'@'10.0.%'   IDENTIFIED BY 'qD3!Lw&E2QuyubMZ$76t';
CREATE USER 'read.only'@'10.0.%' IDENTIFIED BY 'fH0^rJ4Ui7F5IhO4qEt&';
--===== 建帳號權限 =====
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, RELOAD, PROCESS, REFERENCES, INDEX, ALTER, SHOW DATABASES, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, REPLICATION SLAVE, REPLICATION CLIENT, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, CREATE USER, EVENT, TRIGGER, CREATE ROLE, DROP ROLE ON *.* TO 'root'@'%' WITH GRANT OPTION;
GRANT APPLICATION_PASSWORD_ADMIN,BACKUP_ADMIN,FLUSH_OPTIMIZER_COSTS,FLUSH_STATUS,FLUSH_TABLES,FLUSH_USER_RESOURCES,INNODB_REDO_LOG_ARCHIVE,PASSWORDLESS_USER_ADMIN,SHOW_ROUTINE ON *.* TO 'root'@'%' WITH GRANT OPTION;

GRANT PROCESS, REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'app_use'@'10.0.%';
GRANT ALL PRIVILEGES ON `saas\_game`.* TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`func` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`general_log` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`help_category` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`help_keyword` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`help_relation` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`help_topic` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`slow_log` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`time_zone_leap_second` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`time_zone_name` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`time_zone_transition_type` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`time_zone_transition` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`time_zone` TO 'app_use'@'10.0.%';

GRANT PROCESS ON *.* TO 'read.only'@'10.0.%';
GRANT SELECT, LOCK TABLES ON `saas_game`.* TO 'read.only'@'10.0.%';
--===== 權限設定重新讀取 =====
FLUSH PRIVILEGES;


--b-rds57-info
mysql -h b-rds57-info.ckryklccvkik.ap-northeast-1.rds.amazonaws.com -P 3306 -uburokkori -pI&nheyUu%7NHql^dMgZ0
--===== 建帳號用 =====
CREATE USER 'root'@'%'           IDENTIFIED BY 'fC7!bVsWcKbJEni%txlL';
CREATE USER 'app_use'@'10.0.%'   IDENTIFIED BY 'wZ8^daf7tOjU1AG3t7QI';
CREATE USER 'read.only'@'10.0.%' IDENTIFIED BY 'fH0^rJ4Ui7F5IhO4qEt&';
--===== 建帳號權限 =====
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, RELOAD, PROCESS, REFERENCES, INDEX, ALTER, SHOW DATABASES, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, REPLICATION SLAVE, REPLICATION CLIENT, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, CREATE USER, EVENT, TRIGGER, CREATE ROLE, DROP ROLE ON *.* TO 'root'@'%' WITH GRANT OPTION;
GRANT APPLICATION_PASSWORD_ADMIN,BACKUP_ADMIN,FLUSH_OPTIMIZER_COSTS,FLUSH_STATUS,FLUSH_TABLES,FLUSH_USER_RESOURCES,INNODB_REDO_LOG_ARCHIVE,PASSWORDLESS_USER_ADMIN,SHOW_ROUTINE ON *.* TO 'root'@'%' WITH GRANT OPTION;

GRANT PROCESS, REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'app_use'@'10.0.%';
GRANT ALL PRIVILEGES ON `saas\_information`.* TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`func` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`general_log` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`help_category` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`help_keyword` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`help_relation` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`help_topic` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`slow_log` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`time_zone_leap_second` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`time_zone_name` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`time_zone_transition_type` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`time_zone_transition` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`time_zone` TO 'app_use'@'10.0.%';

GRANT PROCESS ON *.* TO 'read.only'@'10.0.%';
GRANT SELECT, LOCK TABLES ON `saas_information`.* TO 'read.only'@'10.0.%';
--===== 權限設定重新讀取 =====
FLUSH PRIVILEGES;


--b-rds57-sns
mysql -h b-rds57-sns.ckryklccvkik.ap-northeast-1.rds.amazonaws.com -P 3306 -uburokkori -pVl7*VQcQJ9vCK89t56VQ
--===== 建帳號用 =====
CREATE USER 'root'@'%'           IDENTIFIED BY 'tK0!LUT&jiatDM!HbK3Y';
CREATE USER 'app_use'@'10.0.%'   IDENTIFIED BY 'dR3&GErLJ$agEMDvZqEp';
CREATE USER 'read.only'@'10.0.%' IDENTIFIED BY 'fH0^rJ4Ui7F5IhO4qEt&';
--===== 建帳號權限 =====
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, RELOAD, PROCESS, REFERENCES, INDEX, ALTER, SHOW DATABASES, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, REPLICATION SLAVE, REPLICATION CLIENT, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, CREATE USER, EVENT, TRIGGER, CREATE ROLE, DROP ROLE ON *.* TO 'root'@'%' WITH GRANT OPTION;
GRANT APPLICATION_PASSWORD_ADMIN,BACKUP_ADMIN,FLUSH_OPTIMIZER_COSTS,FLUSH_STATUS,FLUSH_TABLES,FLUSH_USER_RESOURCES,INNODB_REDO_LOG_ARCHIVE,PASSWORDLESS_USER_ADMIN,SHOW_ROUTINE ON *.* TO 'root'@'%' WITH GRANT OPTION;

GRANT PROCESS, REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'app_use'@'10.0.%';
GRANT ALL PRIVILEGES ON `saas\_sns`.* TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`func` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`general_log` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`help_category` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`help_keyword` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`help_relation` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`help_topic` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`slow_log` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`time_zone_leap_second` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`time_zone_name` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`time_zone_transition_type` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`time_zone_transition` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`time_zone` TO 'app_use'@'10.0.%';

GRANT PROCESS ON *.* TO 'read.only'@'10.0.%';
GRANT SELECT, LOCK TABLES ON `saas_sns`.* TO 'read.only'@'10.0.%';
--===== 權限設定重新讀取 =====
FLUSH PRIVILEGES;


--b-rds57-user
mysql -h b-rds57-user.ckryklccvkik.ap-northeast-1.rds.amazonaws.com -P 3306 -uburokkori -pIkZ7m$mi65Yzr5j5N9V1
--===== 建帳號用 =====
CREATE USER 'root'@'%'           IDENTIFIED BY 'lK4!tWBWrDDTV$qBHi2a';
CREATE USER 'app_use'@'10.0.%'   IDENTIFIED BY 'vL7$Xb$g9kbtmu$swRh3';
CREATE USER 'read.only'@'10.0.%' IDENTIFIED BY 'fH0^rJ4Ui7F5IhO4qEt&';
--===== 建帳號權限 =====
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, RELOAD, PROCESS, REFERENCES, INDEX, ALTER, SHOW DATABASES, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, REPLICATION SLAVE, REPLICATION CLIENT, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, CREATE USER, EVENT, TRIGGER, CREATE ROLE, DROP ROLE ON *.* TO 'root'@'%' WITH GRANT OPTION;
GRANT APPLICATION_PASSWORD_ADMIN,BACKUP_ADMIN,FLUSH_OPTIMIZER_COSTS,FLUSH_STATUS,FLUSH_TABLES,FLUSH_USER_RESOURCES,INNODB_REDO_LOG_ARCHIVE,PASSWORDLESS_USER_ADMIN,SHOW_ROUTINE ON *.* TO 'root'@'%' WITH GRANT OPTION;

GRANT PROCESS, REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'app_use'@'10.0.%';
GRANT ALL PRIVILEGES ON `saas\_user`.* TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`func` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`general_log` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`help_category` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`help_keyword` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`help_relation` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`help_topic` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`slow_log` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`time_zone_leap_second` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`time_zone_name` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`time_zone_transition_type` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`time_zone_transition` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`time_zone` TO 'app_use'@'10.0.%';

GRANT PROCESS ON *.* TO 'read.only'@'10.0.%';
GRANT SELECT, LOCK TABLES ON `saas_user`.* TO 'read.only'@'10.0.%';
--===== 權限設定重新讀取 =====
FLUSH PRIVILEGES;


--b-rds57-xzs
mysql -h b-xzs.ckryklccvkik.ap-northeast-1.rds.amazonaws.com -P 3306 -uburokkori -pB9cfY$mZMxG)41KN%66o
--===== 建帳號用 =====
CREATE USER 'root'@'%'           IDENTIFIED BY 'uW3&NY0^h5Ky2&wg%8Fe';
CREATE USER 'app_use'@'10.0.%'   IDENTIFIED BY 'dI3&BAwKpojvHRAV$PKG';
CREATE USER 'read.only'@'10.0.%' IDENTIFIED BY 'fH0^rJ4Ui7F5IhO4qEt&';
--===== 建帳號權限 =====
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, RELOAD, PROCESS, REFERENCES, INDEX, ALTER, SHOW DATABASES, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, REPLICATION SLAVE, REPLICATION CLIENT, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, CREATE USER, EVENT, TRIGGER, CREATE ROLE, DROP ROLE ON *.* TO 'root'@'%' WITH GRANT OPTION;
GRANT APPLICATION_PASSWORD_ADMIN,BACKUP_ADMIN,FLUSH_OPTIMIZER_COSTS,FLUSH_STATUS,FLUSH_TABLES,FLUSH_USER_RESOURCES,INNODB_REDO_LOG_ARCHIVE,PASSWORDLESS_USER_ADMIN,SHOW_ROUTINE ON *.* TO 'root'@'%' WITH GRANT OPTION;

GRANT PROCESS, REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'app_use'@'10.0.%';
GRANT ALL PRIVILEGES ON `saas\_user`.* TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`func` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`general_log` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`help_category` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`help_keyword` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`help_relation` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`help_topic` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`slow_log` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`time_zone_leap_second` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`time_zone_name` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`time_zone_transition_type` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`time_zone_transition` TO 'app_use'@'10.0.%';
GRANT SELECT ON `mysql`.`time_zone` TO 'app_use'@'10.0.%';

GRANT PROCESS ON *.* TO 'read.only'@'10.0.%';
GRANT SELECT, LOCK TABLES ON `saas_user`.* TO 'read.only'@'10.0.%';
--===== 權限設定重新讀取 =====
FLUSH PRIVILEGES;


--b-rds57-swift
mysql -h b-rds57-swift.ckryklccvkik.ap-northeast-1.rds.amazonaws.com -P 3306 -utamanegi -prR3S4-CaEBBG9pTf2wp+hHXbVQz.GqXa
--===== 建帳號用 =====
CREATE USER 'root'@'%'           IDENTIFIED BY 'zA2!d5PenlW&%u$0UeFP';
CREATE USER 'app_use'@'10.0.%'   IDENTIFIED BY 'rH7$Iq97la^sM4o8vTS0';
CREATE USER 'read.only'@'10.0.%' IDENTIFIED BY 'fH0^rJ4Ui7F5IhO4qEt&';
--===== 建帳號權限 =====
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, RELOAD, PROCESS, REFERENCES, INDEX, ALTER, SHOW DATABASES, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, REPLICATION SLAVE, REPLICATION CLIENT, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, CREATE USER, EVENT, TRIGGER, CREATE ROLE, DROP ROLE ON *.* TO 'root'@'%' WITH GRANT OPTION;
GRANT APPLICATION_PASSWORD_ADMIN,BACKUP_ADMIN,FLUSH_OPTIMIZER_COSTS,FLUSH_STATUS,FLUSH_TABLES,FLUSH_USER_RESOURCES,INNODB_REDO_LOG_ARCHIVE,PASSWORDLESS_USER_ADMIN,SHOW_ROUTINE ON *.* TO 'root'@'%' WITH GRANT OPTION;

| GRANT PROCESS, REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'app_use'@'10.0.%';
| GRANT ALL PRIVILEGES ON `swift`.* TO 'app_use'@'10.0.%';
| GRANT SELECT ON `mysql`.`func` TO 'app_use'@'10.0.%';
| GRANT SELECT ON `mysql`.`general_log` TO 'app_use'@'10.0.%';
| GRANT SELECT ON `mysql`.`help_category` TO 'app_use'@'10.0.%';
| GRANT SELECT ON `mysql`.`help_keyword` TO 'app_use'@'10.0.%';
| GRANT SELECT ON `mysql`.`help_relation` TO 'app_use'@'10.0.%';
| GRANT SELECT ON `mysql`.`help_topic` TO 'app_use'@'10.0.%';
| GRANT SELECT ON `mysql`.`slow_log` TO 'app_use'@'10.0.%';
| GRANT SELECT ON `mysql`.`time_zone_leap_second` TO 'app_use'@'10.0.%';
| GRANT SELECT ON `mysql`.`time_zone_name` TO 'app_use'@'10.0.%';
| GRANT SELECT ON `mysql`.`time_zone_transition_type` TO 'app_use'@'10.0.%';
| GRANT SELECT ON `mysql`.`time_zone_transition` TO 'app_use'@'10.0.%';
| GRANT SELECT ON `mysql`.`time_zone` TO 'app_use'@'10.0.%';

GRANT PROCESS ON *.* TO 'read.only'@'10.0.%';
GRANT SELECT, LOCK TABLES ON `swift`.* TO 'read.only'@'10.0.%';
--===== 權限設定重新讀取 =====
FLUSH PRIVILEGES;