#!/bin/bash
# Run all commands needed to install Hornet
apt update && apt dist-upgrade -y
apt install build-essential git
# Install Goland 1.16 
wget https://golang.org/dl/go1.16.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.16.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
cd /opt
# Open dash and TCP ports
ufw allow 8081/tcp
ufw allow 15600/tcp
# Clone Hornet from develop branch
git clone -b develop --single-branch https://github.com/gohornet/hornet
cd hornet
go build
mkdir /opt/hornet-testnet
cp /opt/hornet/hornet /opt/hornet-testnet
cp /opt/hornet/config_chrysalis_testnet.json /opt/hornet-testnet
cp /opt/hornet/peering.json /opt/hornet-testnet
cp /opt/hornet/profiles.json /opt/hornet-testnet
# Add Hornet as Service
wget https://raw.githubusercontent.com/demichele/install-hornet-1.5/main/hornet-testnet.service
mv hornet-testnet.service /lib/systemd/system/hornet-testnet.service
systemctl enable hornet-testnet.service
systemctl start hornet-testnet && journalctl -u hornet-testnet -f

