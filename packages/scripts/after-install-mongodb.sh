#!/bin/bash
mkdir -p /data/mongdb/db/ 
echo "exclude=mongodb*" >> /etc/yum.conf
systemctl daemon-reload && systemctl enable mongod.service && systemctl start mongod.service

# 运行 MongoDB 命令创建用户
/usr/local/mongodb/bin/mongo --port 27218 --eval 'db.getSiblingDB("admin").createUser({ user: "admin", pwd: "Zx9InNnump6^ITq4", roles: [ { role: "root", db: "admin" } ] })' > /dev/null 2>&1

# 判断命令是否成功执行
if [ $? -eq 0 ]; then
  echo "Zx9InNnump6^ITq4" > /etc/savepmongdb
  chmod 600 /etc/savepmongdb
  echo "mongodb 默认账号 admin 密码为: Zx9InNnump6^ITq4",保存密码文件为/etc/savepmongdb
  echo "开始开启密码认证"
  sed -i 's/authorization:\ disabled/#authorization:\ disabled/g' /usr/local/mongodb/mongodb.conf
  sed -i 's/#authorization:\ enabled/authorization:\ enabled/g' /usr/local/mongodb/mongodb.conf
else
  echo "麻烦手动设置 admin 密码为: Zx9InNnump6^ITq4"
fi

