#!/bin/sh

# Releasing the Memory
#1. Freeing Up the Page Cache
#echo 1 > /proc/sys/vm/drop_caches

#2. Freeing Up the Dentries and Inodes
#echo 2 > /proc/sys/vm/drop_caches

#3. Freeing Up the Page Cache, Dentries and Inodes
#echo 3 > /proc/sys/vm/drop_caches

echo 3 > /proc/sys/vm/drop_caches

