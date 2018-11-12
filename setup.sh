#!/bin/sh

cp ./root/* /root/
chmod +x /root/*

! [ -d /mnt/iso ] && mkdir /mnt/iso
! [ -d /mnt/local-vmexport ] && mkdir /mnt/local-vmexport

xe-mount-iso-sr /mnt/iso -o bind

cp ./mnt/local-vmexport/* /mnt/local-vmexport/
chmod +x /mnt/local-vmexport/VmBackup.py
chmod +x /mnt/local-vmexport/vm-backup.sh

cat ./etc/exports >> /etc/exports
service nfs-server restart

LINE_NUM_1=`grep -nr ^-A\ FORWARD /etc/sysconfig/iptables|sed 's/:/ /g'|awk '{print $1}'`
LINE_NUM_2=`echo $LINE_NUM_1|awk '{print $1+1}'`

head -n $LINE_NUM_1 /etc/sysconfig/iptables > ./iptables.new
echo "" >> ./iptables.new
echo "# NFS SECTION" >> ./iptables.new
rpcinfo -p|awk '/(tcp|udp)/{print "-A RH-Firewall-1-INPUT -m state --state NEW -m "$3" -p "$3" --dport "$4" -j ACCEPT"}'|sort|uniq >> ./iptables.new
echo "# END OF NFS" >> ./iptables.new
echo "" >> ./iptables.new
tail -n +$LINE_NUM_2 /etc/sysconfig/iptables >> ./iptables.new

cp /etc/sysconfig/iptables ./iptables.bak
cat ./iptables.new > /etc/sysconfig/iptables

service iptables restart

echo "Create vmexport password file"
echo "./VmBackup.py <password> create-password-file=$(hostname).pass"
echo "Input vmexport login password:"
read -s p1
echo "Confirm vmexport login password:"
read -s p2

[ "$p1" -ne "$p2" ] && (echo "Two passwords input does not matched"; exit -1)

/mnt/local-vmexport/VmBackup.py $p2 create-password-file=/mnt/local-vmexport/$(hostname).pass
