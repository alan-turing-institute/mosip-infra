#!/bin/sh

# script to start up vms.
#az vm start --ids $(az vm list -g <resourcegroupname> --query "[].id" -o tsv)
rg=mosip-sandbox-test

az account set -s a8604fcd-7cc8-4801-a975-a4b777a179a4
echo "Starting console.sb"
az vm start --resource-group $rg --name console.sb 
echo "console.sb started 1/7"

echo "starting nginx on console.sb"
az vm run-command invoke -g $rg -n console.sb --command-id RunShellScript --scripts "sudo systemctl enable nginx && sudo systemctl start nginx"
echo "nginx started on console.sb"

echo "Starting mzmaster.sb"
az vm start --resource-group $rg --name mzmaster.sb
echo "mzmaster.sb started 2/7"

echo "disabling swapoff on mzmaster.sb"
az vm run-command invoke -g $rg -n mzmaster.sb --command-id RunShellScript --scripts "sudo -i && swapoff -a"
echo "disabled swapoff on mzmaster.sb"

echo "Starting mzworker0.sb"
az vm start --resource-group $rg --name mzworker0.sb
echo "mzworker0.sb started 3/7"

echo "Starting mzworker1.sb"
az vm start --resource-group $rg --name mzworker1.sb
echo "mzworker1.sb started 4/7"

echo "Starting mzworker2.sb"
az vm start --resource-group $rg --name mzworker2.sb 
echo "mzworker2.sb started 5/7"

echo "Starting dmzworker.sb"
az vm start --resource-group $rg --name dmzmaster.sb 
echo "dmzmaster.sb started 6/7"

echo "disabling swapoff on dmzmaster.sb"
az vm run-command invoke -g $rg -n dmzmaster.sb --command-id RunShellScript --scripts "sudo -i && swapoff -a"
echo "disabled swapoff on dmzmaster.sb"

echo "starting dmzworker0.sb"
az vm start --resource-group $rg --name dmzworker0.sb
echo "dmzworker0.sb started 7/7"


