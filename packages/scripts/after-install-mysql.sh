#!/bin/bash
#install 5.7.27  server
####默认密码
passVar=tQVy4#zEo0xqWHu8

group=mysql
user=mysql

#install  lib
#rpm -qa |grep libaio >& /dev/null
#if [ $? -ne 0 ];then
#    rpm  -vih  /home/software/mysql/packages/libaio-0.3.109-13.el7.x86_64.rpm
#    echo "依赖安装完成"
#fi

#create group if not exists
egrep "^$group" /etc/group >& /dev/null
if [ $? -ne 0 ];then
    groupadd $group
    echo  "完成用户组创建"
fi

#create user if not exists
egrep "^$user" /etc/passwd >& /dev/null
if [ $? -ne 0 ];then
    useradd -g $group -M -s /sbin/nologin $user
    echo "完成用户创建"
fi
echo  "安装前的准备工作完成～～～"

#Set permissions
mkdir -p /data/mysql/ && chown -R mysql:mysql /data/mysql/

for cmd in mysql mysqld mysqldump
do
    ln -s   /usr/local/mysql/bin/$cmd  /usr/bin/
done

systemctl daemon-reload && systemctl enable mysqld.service

#init
/usr/local/mysql/bin/mysqld --initialize-insecure --user=mysql --basedir=/usr/local/mysql --datadir=/data/mysql/
systemctl restart mysqld.service
echo $passVar > /etc/savep && chmod 600 /etc/savep
/usr/local/mysql/bin/mysqladmin -uroot password "$passVar"
/usr/local/mysql/bin/mysql -uroot -p$passVar -e 'use mysql;delete  from user where user="";'
/usr/local/mysql/bin/mysql -uroot -p$passVar -e "GRANT USAGE,PROCESS,SUPER,REPLICATION CLIENT,REPLICATION SLAVE,SELECT  ON *.* TO zabbixuser@'127.0.0.1' IDENTIFIED BY 'zabbixusermy4399'; flush privileges;"

echo "exclude=mysql*" >> /etc/yum.conf
