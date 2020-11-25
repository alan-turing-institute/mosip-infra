#!/bin/sh

# script to install MOSIP on vm
echo "STEP 4: PREPARE CONSOLE VM FOR MOSIP INSTALL"

dns="sandbox.uksouth.cloudapp.azure.com"
ssh mosipuser@sandbox.uksouth.cloudapp.azure.com
cd ~/
git clone https://github.com/mosip/mosip-infra
cd mosip-infra
git checkout 1.1.2
cd deployment/sandbox-v2
./key.sh hosts.ini
./preinstall.sh
$ source ~/.bashrc

echo "STEP 5: EDIT group_vars/all.yml"

sed -i "" "15s/minibox.mosip.net/$dns/" ./group_vars/all.yml
echo "updated sandbox domain name to $dns"

echo "STEP 6: RETRIEVE PRIVATE IPs AND EDIT hosts.ini"

az account set -s a8604fcd-7cc8-4801-a975-a4b777a179a4

# Brute force since I'm a bash noob
vm="console"
ip=$(az vm show -g mosip-sandbox-test -n $vm --query privateIps -d --out tsv)
sed -i "" "4s/$vm.sb/$vm/" ./hosts.ini
sed -i "" "4s/10.20.20.10/$ip/" ./hosts.ini

vm="mzmaster"
ip=$(az vm show -g mosip-sandbox-test -n $vm --query privateIps -d --out tsv)
sed -i "" "8s/$vm.sb/$vm/" ./hosts.ini
sed -i "" "8s/10.20.20.99/$ip/" ./hosts.ini

vm="mzworker0"
ip=$(az vm show -g mosip-sandbox-test -n $vm --query privateIps -d --out tsv)
sed -i "" "10s/$vm.sb/$vm/" ./hosts.ini
sed -i "" "10s/10.20.20.100/$ip/" ./hosts.ini

vm="mzworker1"
ip=$(az vm show -g mosip-sandbox-test -n $vm --query privateIps -d --out tsv)
sed -i "" "11s/$vm.sb/$vm/" ./hosts.ini
sed -i "" "11s/10.20.20.101/$ip/" ./hosts.ini

vm="mzworker2"
ip=$(az vm show -g mosip-sandbox-test -n $vm --query privateIps -d --out tsv)
sed -i "" "12s/$vm.sb/$vm/" ./hosts.ini
sed -i "" "12s/10.20.20.102/$ip/" ./hosts.ini

vm="dmzmaster"
ip=$(az vm show -g mosip-sandbox-test -n $vm --query privateIps -d --out tsv)
sed -i "" "22s/$vm.sb/$vm/" ./hosts.ini
sed -i "" "22s/10.20.20.199/$ip/" ./hosts.ini

vm="dmzmaster0"
ip=$(az vm show -g mosip-sandbox-test -n $vm --query privateIps -d --out tsv)
sed -i "" "24s/$vm.sb/$vm/" ./hosts.ini
sed -i "" "24s/10.20.20.200/$ip/" ./hosts.ini

an site.yml