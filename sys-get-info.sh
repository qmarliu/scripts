#!/bin/bash
set -e
echo "###############获取CPU 个数、核数以及型号信息##############################"
grep 'physical id' /proc/cpuinfo | sort -u
grep 'core id' /proc/cpuinfo | sort -u |wc -l
grep 'model name' /proc/cpuinfo | sort -u

echo "##############获取MEM 个数以及型号信息#####################################"
sudo dmidecode|grep -P -A5 "Memory\s+Device"|grep Size|grep -v Range

echo "############# 获取主板信息 ################################################"
sudo dmidecode |grep 'Product Name'

echo "#############获取主机HDD、SSD信息##########################################"
lsscsi

echo "#############获取主机GPU 信息#############################################"
lspci | grep -i nvidia|grep 'GeForce RTX 2080'

echo "#############获取主机Ethernet 信息########################################"
lspci |grep 'Ethernet controller'
