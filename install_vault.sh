#!/bin/bash
set -x
# Install Vault Server on Linux Platform 

tag=${1:-1.5.4}
vault=vault_${tag}_linux_amd64.zip
url=https://releases.hashicorp.com/vault/${tag}/${vault}
echo "Downloading ${tag} version of Vault"
wget -c -q ${url} && sudo unzip -d /usr/bin ${vault} && rm ${vault} 
sudo setcap cap_ipc_lock=+ep $(readlink -f $(which vault))

# Add vault user and group
sudo useradd -r -d /opt/vault/vault-data -s /bin/nologin vault
sudo install -o vault -g vault -m 750 -d /opt/vault/vault-data

# creat vault director in /etc
sudo mkdir -p /etc/vault
# create log directory for vault
sudo mkdir -p /var/log/vault
sudo install -o vault -g vault -m 750 -d /var/log/vault


# generate certs for tls
cert=/etc/vault/certs
sudo openssl genrsa -out ${cert}.key 2048
sudo openssl req -new -key ${cert}.key -out ${cert}.csr \
  -extensions v3_ca \
  -subj "/C=US/ST=CA/O=Iono/L=San Jose/OU=Iono/CN=Universal CA root"
sudo openssl x509 -req -days 3650 -in ${cert}.csr -signkey ${cert}.key \
  -out ${cert}.crt
sudo chown -R vault:vault ${cert}.*

# copy vault.service to systemd
sudo cp config.hcl /etc/vault/
sudo cp vault.service /etc/systemd/system/vault.service

# start vault deamon
sudo systemctl deamon-reload
sudo systemctl enable vault.service
sudo systemctl start vault.service

