#! /bin/bash

uname -a
echo "#CPU physical : $(grep 'physical id' /proc/cpuinfo | uniq | wc -l)"
echo "#vCPU : $(grep 'processor' /proc/cpuinfo | uniq | wc -l)"
echo "#Memory Usage: $(free -m | awk 'NR == 2 {printf "%i/%i (%.2f%%)",$3,$2,($3 / $2 * 100)}')"
echo "#Disk Usage: $(df -m --total | grep '/dev/mapper/sda5_crypt-vg--root' | awk '{printf $3"/"$2" ("int($5)}')%)"
echo "#CPU load: $(top -bn1 | grep load | awk '{printf"%.2f%%\n", $(NF-2)}')"
echo "#Last boot: $(who -b | awk '{printf $3}')"
if [[ $(cat /etc/fstab | grep -c '/dev/mapper') ]]; then echo "#LVM use: yes"; else echo "#LVM use: no"; fi
echo "#Connexions TCP : $(if echo -n "$(ss -s | awk '/TCP:/{print $2}')"; then echo " ESTABLISHED"; else echo " NOT ESTABLISHED"; fi)"
echo "#User log: $(who | wc | awk '{printf $1}')"
echo "#Network: IP $(hostname -I) ($(/usr/sbin/ifconfig | awk '/ether/{print $2}'))"
echo "#Sudo : $(grep -c 'COMMAND' /var/log/sudo/sudologs.txt) cmd"
