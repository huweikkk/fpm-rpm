#!/bin/bash
systemctl stop php-fpm7
sed -i '/exclude=php-fpm*/d' /etc/yum.conf
