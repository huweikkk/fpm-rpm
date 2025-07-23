#!/bin/bash
systemctl stop redis
sed -i '/exclude=redis*/d' /etc/yum.conf
