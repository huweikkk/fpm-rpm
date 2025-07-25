#Centos7下运维常用中间件，使用fpm输出rpm包

##fpm打包命令

```
cat Dockerfile
FROM tenzer/fpm:latest

ENTRYPOINT ["/bin/sh"]

docker build -t fpm .
docker run --name fpm -it -d -v /data:/data fpm

fpm -s dir \
  -C /data/fpm/packages/nginx \
  -t rpm \
  -n nginx \
  -v "1.26.2" \
  --after-install /data/fpm/packages/scripts/after-install-nginx.sh \
  --before-remove /data/fpm/packages/scripts/before-remove-nginx.sh \
  -f \
  -p /data/fpm/packages/output/


fpm -s dir \
  -C /data/fpm/packages/redis \
  -t rpm \
  -n redis \
  -v "5.0.14" \
  --after-install /data/fpm/packages/scripts/after-install-redis.sh \
  --before-remove /data/fpm/packages/scripts/before-remove-redis.sh \
  -f \
  -p /data/fpm/packages/output/


fpm -s dir \
  -C /data/fpm/packages/php56/ \
  -t rpm \
  -n php56 \
  -v "5.6.33" \
  --after-install /data/fpm/packages/scripts/after-install-php56.sh \
  --before-remove /data/fpm/packages/scripts/before-remove-php56.sh	 \
  --depends libtool-ltdl \
  --depends libtool-ltdl-devel \
  -f \
  -p /data/fpm/packages/output/


fpm -s dir \
  -C /data/fpm/packages/php74/ \
  -t rpm \
  -n php74 \
  -v "7.4.33" \
  --after-install /data/fpm/packages/scripts/after-install-php74.sh \
  --before-remove /data/fpm/packages/scripts/before-remove-php74.sh	 \
  --depends libwebp \
  --depends libjpeg \
  --depends oniguruma \
  --depends oniguruma-devel \
  --depends libicu \
  --depends c-ares \
  -f \
  -p /data/fpm/packages/output/



  fpm -s dir \
  -C /data/fpm/packages/php7/ \
  -t rpm \
  -n php71 \
  -v "7.1.15" \
  --after-install /data/fpm/packages/scripts/after-install-php7.sh \
  --before-remove /data/fpm/packages/scripts/before-remove-php7.sh \
  --depends libwebp \
  --depends libjpeg \
  --depends oniguruma \
  --depends oniguruma-devel \
  --depends libicu \
  --depends c-ares \
  -f \
  -p /data/fpm/packages/output/



fpm -s dir \
  -C /data/fpm/packages/mysql/ \
  -t rpm \
  -n mysql \
  -v "5.7.27" \
  --after-install /data/fpm/packages/scripts/after-install-mysql.sh \
  --before-remove /data/fpm/packages/scripts/before-remove-mysql.sh \
  --depends libaio \
  -f \
  -p /data/fpm/packages/output/
```
###中间件配置文件以及密码
| 中间件     | 目录                | 配置文件                               | 启动服务               | 默认密码                      |
|------------|---------------------|----------------------------------------|------------------------|-------------------------------|
| nginx      | /usr/local/nginx/    | /usr/local/nginx/conf/nginx.conf       | systemctl start nginx   |                               |
| redis      | /usr/local/redis/    | /usr/local/redis/etc/redis.conf        | systemctl start redis   | 默认不启用，自行修改配置       |
| php-fpm56  | /usr/local/php56     | /usr/local/php56/etc/php-fpm.conf      | systemctl start php-fpm56|                               |
| php-fpm7   | /usr/local/php7      | /usr/local/php7/etc/php-fpm.conf       | systemctl start php-fpm7 |                               |
| php-fpm74  | /usr/local/php74     | /usr/local/php74/etc/php-fpm.conf      | systemctl start php-fpm74|                               |
| mysql      | /usr/local/mysql/    | /etc/my.cnf                            | systemctl start mysqld  | tQVy4#zEo0xqWHu8               |
