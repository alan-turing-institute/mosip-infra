#!/bin/sh

# script to deallocate vms.
#az vm deallocate --ids $(az vm list -g <resourcegroupname> --query "[].id" -o tsv)
az account set -s a8604fcd-7cc8-4801-a975-a4b777a179a4
az vm deallocate --resource-group mosip-sandbox-test --name console.sb
echo "console deallocated 1/7"
az vm deallocate --resource-group mosip-sandbox-test --name mzmaster.sb
echo "mzmaster deallocated 2/7"
az vm deallocate --resource-group mosip-sandbox-test --name mzworker0.sb
echo "mzworker0 deallocated 3/7"
az vm deallocate --resource-group mosip-sandbox-test --name mzworker1.sb
echo "mzworker1 deallocated 4/7"
az vm deallocate --resource-group mosip-sandbox-test --name mzworker2.sb
echo "mzworker2 deallocated 5/7"
az vm deallocate --resource-group mosip-sandbox-test --name dmzmaster.sb
echo "dmzmaster deallocated 6/7"
az vm deallocate --resource-group mosip-sandbox-test --name dmzworker0.sb
echo "dmzworker0 deallocated 7/7"