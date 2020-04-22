#!/bin/bash

apt update
pushd rak
./install.sh
sleep 1
popd

pushd lora
./install.sh
sleep 1
popd

#pushd sysconf
#./install.sh
#sleep 1
#popd

echo "*********************************************************"
echo "*  The RAKwireless gateway is successfully installed!   *"
echo "*********************************************************"
