#!/bin/bash
systemctl stop mysqld
sed -i '/exclude=mysql*/d' /etc/yum.conf
