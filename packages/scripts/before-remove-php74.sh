#!/bin/bash
systemctl stop php-fpm74
sed -i '/exclude=php-fpm*/d' /etc/yum.conf
