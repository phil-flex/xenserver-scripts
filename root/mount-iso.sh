#!/bin/sh
#sleep 20
VG=`lvs |awk '/isoLibs/ {print $2}'`
SR=`xe sr-list name-label=Remote\ ISO\ Library\ on:\ /mnt/iso |awk '/^uuid/ {print $5}'`
PD=`xe pbd-list sr-uuid=$SR|awk '/^uuid/ {print $5}'`
vgchange -ay $VG --config global{metadata_read_only=0}
mount /dev/$VG/isoLibs /mnt/iso
xe pbd-unplug uuid=$PD
xe pbd-plug uuid=$PD
