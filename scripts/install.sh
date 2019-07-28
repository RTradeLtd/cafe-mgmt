#! /bin/bash

# downloads and install a go-textile node

#########
# SETUP #
#########

WORDS=24
PASSPHRASE="$1"
VERSION="v0.6.6"
DISPLAY_NAME="$2"
URL=https://github.com/textileio/go-textile/releases/download/"$VERSION"/go-textile_"$VERSION"_linux-amd64.tar.gz

function error_handle() {
    if [[ "$?" != 0 ]]; then
        echo "[ERROR] the last command failed, see logs for details"
        exit 1
    fi
}

#########
# BEGIN #
#########

if [[ "$PASSPHRASE" == "" ]]; then
    echo "[ERROR] no passphrase provided, please run ./install.sh <passphrase>"
    exit
fi

if [[ "$DISPLAY_NAME" == "" ]]; then
    DISPLAY_NAME=$(hostname)
fi

echo "[INFO downloading zabbix"
wget https://repo.zabbix.com/zabbix/4.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_4.0-2+bionic_all.deb
sudo dpkg -i zabbix-release_4.0-2+bionic_all.deb
sudo apt update 
sudo apt install zabbix-agent
rm zabbix-release_4.0-2+bionic_all.deb

echo "[INFO] downloading go-textile"
# download go-textile
wget "$URL"
error_handle

echo "[INFO] preparing for installation"
# cleanup old installation files
rm -rf ./textile
mkdir textile

# untar install files
tar -C textile -zxvf go-textile*.tar.gz
error_handle
rm *.tar.gz
error_handle

# change to install directory
cd textile || exit

echo "[INFO] installing go-textile"
# install go-textile
sudo ./install
error_handle
echo "[INFO] installed go-textile"

echo "[INFO] creating wallet"
textile wallet create --words="$WORDS" "$PASSPHRASE" 2>&1 | tee --append create.log
error_handle
echo "[INFO] created wallet"
# grab the private key to create an account with
ACCOUNT=$(tail -n 1 create.log)
if [[ "$ACCOUNT" == "" ]]; then
    echo "[ERROR} failed to get account seed key"
    exit 1
fi
echo "[INFO] initializing cafe"
textile init --cafe --cafe-open --server "$ACCOUNT"
error_handle
echo "[INFO] initialized cafe"