#!/bin/bash

# Stop on the first sign of trouble
set -e

systemctl disable hciuart

apt install git ppp dialog jq minicom monit i2c-tools -y

cp gateway-config /usr/bin/
cp gateway-version /usr/bin/
cp rak /usr/local/ -rf

rm -rf /usr/local/rak/first_boot

echo
echo "RAK Install Success!"
echo