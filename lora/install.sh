#!/bin/bash

# Stop on the first sign of trouble
set -e

if [ ! -d lora_gateway ]; then
    git clone https://github.com/Lora-net/lora_gateway.git
else
    pushd lora_gateway
    git pull
    popd
fi

if [ ! -d packet_forwarder ]; then
    git clone https://github.com/Lora-net/packet_forwarder.git
else
    pushd packet_forwarder
    git pull
    popd
fi

mkdir -p /usr/local/rak/lora
mkdir -p /opt/ttn-gateway

pushd rak2245
./install.sh
popd

cp rak2245/lora_gateway /opt/ttn-gateway/ -rf
cp rak2245/packet_forwarder /opt/ttn-gateway/ -rf


cp ./update_gwid.sh /opt/ttn-gateway/packet_forwarder/lora_pkt_fwd/update_gwid.sh
cp ./start.sh  /opt/ttn-gateway/packet_forwarder/lora_pkt_fwd/start.sh
cp ./set_eui.sh  /opt/ttn-gateway/packet_forwarder/lora_pkt_fwd/set_eui.sh
#cp ttn-gateway.service /lib/systemd/system/ttn-gateway.service
cp /opt/ttn-gateway/packet_forwarder/lora_pkt_fwd/global_conf/global_conf.eu_863_870.json \
	/opt/ttn-gateway/packet_forwarder/lora_pkt_fwd/global_conf.json
	
rpi_model=`do_get_rpi_model`
if [ $rpi_model -eq 3 ] || [ $rpi_model -eq 4 ]; then
    sed -i "s/^.*server_address.*$/\t\"server_address\": \"127.0.0.1\",/" \
	/opt/ttn-gateway/packet_forwarder/lora_pkt_fwd/global_conf.json
fi

#systemctl enable ttn-gateway.service

echo
echo "LoRa Install Success!"
echo