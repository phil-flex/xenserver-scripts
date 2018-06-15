#!/bin/sh
VG=`lvs|awk '/vmexport/ {print $2}'`
vgchange -ay $VG --config global{metadata_read_only=0}
mount /dev/$VG/vmexport /mnt/local-vmexport/
