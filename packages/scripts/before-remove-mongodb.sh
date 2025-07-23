#!/bin/bash
systemctl stop mongod.service
sed -i '/exclude=mongodb*/d' /etc/yum.conf
