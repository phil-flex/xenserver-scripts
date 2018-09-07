#!/bin/sh
cfg=`echo $(hostname).$1.cfg|sed -e 's/\.\./\./'`
cd /mnt/local-vmexport/
./VmBackup.py $(hostname).pass $cfg compress=True
