#!/bin/bash

#$1=create_img

SCRIPT_COMMON_FILE=$(pwd)/rak/rak/shell_script/rak_common.sh
source $SCRIPT_COMMON_FILE

print_help()
{
    echo "--help                Print help info."
    echo ""
    echo "--chirpstack=[install/not_install]"
    echo "                      Chirpstack, default value is install"
    echo ""
    exit
}

INSTALL_CHIRPSTACK=0

CREATE_IMG=""

JSON_FILE=./rak/rak/rak_gw_model.json
RAK_GW_JSON=./rak/rak/gateway-config-info.json
INSTALL_LTE=0
GW_MODEL=RAK2245
ENABLE_SPI=1

linenum=`sed -n "/spi/=" $JSON_FILE`
sed -i "${linenum}c\\\\t\"spi\": \"$ENABLE_SPI\"" $JSON_FILE

linenum=`sed -n "/gw_model/=" $JSON_FILE`
sed -i "${linenum}c\\\\t\"gw_model\": \"$GW_MODEL\"," $JSON_FILE

linenum=`sed -n "/install_lte/=" $RAK_GW_JSON`
sed -i "${linenum}c\\\\t\"install_lte\": \"$INSTALL_LTE\"," $RAK_GW_JSON

apt update
pushd rak
./install.sh $CREATE_IMG
sleep 1
popd
set +e
write_json_chirpstack_install $INSTALL_CHIRPSTACK
set -e

pushd lora
./install.sh $CREATE_IMG
sleep 1
popd

pushd sysconf
./install.sh $CREATE_IMG
sleep 1
popd

echo_success "*********************************************************"
echo_success "*  The RAKwireless gateway is successfully installed!   *"
echo_success "*********************************************************"
