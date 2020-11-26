#!/bin/sh
echo "STEP 4: EDIT group_vars/all.yml"

cd ~/mosip-infra/deployment/sandbox-v2

dns="sandbox.uksouth.cloudapp.azure.com"
sed -i "" "15s/minibox.mosip.net/$dns/" ./group_vars/all.yml
echo "updated sandbox domain name to $dns"

echo "STEP 5: RETRIEVE PRIVATE IPs AND EDIT hosts.ini"

az account set -s a8604fcd-7cc8-4801-a975-a4b777a179a4

# Brute force since I'm a bash noob
vm="console"
ip=$(az vm show -g mosip-sandbox-test -n $vm --query privateIps -d --out tsv)
sed -i "" "4s/$vm.sb/$vm/" ./hosts.ini
sed -i "" "4s/[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*$/$ip/" ./hosts.ini

vm="mzmaster"
ip=$(az vm show -g mosip-sandbox-test -n $vm --query privateIps -d --out tsv)
sed -i "" "8s/$vm.sb/$vm/" ./hosts.ini
sed -i "" "8s/[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*$/$ip/" ./hosts.ini

vm="mzworker0"
ip=$(az vm show -g mosip-sandbox-test -n $vm --query privateIps -d --out tsv)
sed -i "" "10s/$vm.sb/$vm/" ./hosts.ini
sed -i "" "10s/[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*$/$ip/" ./hosts.ini

vm="mzworker1"
ip=$(az vm show -g mosip-sandbox-test -n $vm --query privateIps -d --out tsv)
sed -i "" "11s/$vm.sb/$vm/" ./hosts.ini
sed -i "" "11s/[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*$/$ip/" ./hosts.ini

vm="mzworker2"
ip=$(az vm show -g mosip-sandbox-test -n $vm --query privateIps -d --out tsv)
sed -i "" "12s/$vm.sb/$vm/" ./hosts.ini
sed -i "" "12s/[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*$/$ip/" ./hosts.ini

vm="dmzmaster"
ip=$(az vm show -g mosip-sandbox-test -n $vm --query privateIps -d --out tsv)
sed -i "" "22s/$vm.sb/$vm/" ./hosts.ini
sed -i "" "22s/[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*$/$ip/" ./hosts.ini

vm="dmzworker0"
ip=$(az vm show -g mosip-sandbox-test -n $vm --query privateIps -d --out tsv)
sed -i "" "24s/$vm.sb/$vm/" ./hosts.ini
sed -i "" "24s/[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*$/$ip/" ./hosts.ini

git add hosts.ini
git add ./group_vars/all.yml
git commit -m "edit mosip ips"
git push
