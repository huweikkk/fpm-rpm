#!/bin/bash
groupadd www
useradd -g www www -s /bin/false
echo "手动执行以下操作:yum install -y zlib zlib-devel openssl openssl-devel pcre-devel libxml2 libxml2-devel libcurl libcurl-devel libpng-devel libjpeg-devel freetype-devel libmcrypt-devel openssh-server python-setuptools oniguruma oniguruma-devel sqlite-devel c-ares-devel libicu libwebp-devel libtool-ltdl  libtool-ltdl-devel"
systemctl daemon-reload && systemctl enable php-fpm56
echo "exclude=php-fpm*" >> /etc/yum.conf
