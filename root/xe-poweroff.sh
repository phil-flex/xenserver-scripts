#!/bin/sh
xe host-disable host=$(xe host-list params=uuid name-label=`hostname` |awk '{print $5}')
xe vm-shutdown --multiple
xe vm-shutdown --multiple --force
xe host-shutdown host=`hostname`
#poweroff
