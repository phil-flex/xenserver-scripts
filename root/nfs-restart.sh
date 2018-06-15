#!/bin/sh
systemctl restart iptables.service
systemctl restart nfs.service
systemctl restart nfslock.service

