#!/bin/bash

# Stop on the first sign of trouble
set -e

# add rak_script to rc.local
linenum=`sed -n '/rak_script/=' /etc/rc.local`
if [ ! -n "$linenum" ]; then
        set -a line_array
        line_index=0
        for linenum in `sed -n '/exit 0/=' /etc/rc.local`; do line_array[line_index]=$linenum; let line_index=line_index+1; done
        sed -i "${line_array[${#line_array[*]} - 1]}i/usr/local/rak/bin/rak_script" /etc/rc.local
fi

echo
echo "SYS Conf Install Success!"
echo