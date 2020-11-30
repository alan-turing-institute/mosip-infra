#!/bin/sh

# script to start up vms.
az account set -s a8604fcd-7cc8-4801-a975-a4b777a179a4
az vm deallocate --resource-group mosip-sandbox-test --name console
echo "console deallocated 1/7"
az vm deallocate --resource-group mosip-sandbox-test --name mzmaster
echo "mzmaster deallocated 2/7"
az vm deallocate --resource-group mosip-sandbox-test --name mzworker0
echo "mzworker0 deallocated 3/7"
az vm deallocate --resource-group mosip-sandbox-test --name mzworker1
echo "mzworker1 deallocated 4/7"
az vm deallocate --resource-group mosip-sandbox-test --name mzworker2
echo "mzworker2 deallocated 5/7"
az vm deallocate --resource-group mosip-sandbox-test --name dmzmaster
echo "dmzmaster deallocated 6/7"
az vm deallocate --resource-group mosip-sandbox-test --name dmzworker0
echo "dmzworker0 deallocated 7/7"
