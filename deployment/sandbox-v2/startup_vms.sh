#!/bin/sh

# script to start up vms.
az account set -s a8604fcd-7cc8-4801-a975-a4b777a179a4
az vm start --resource-group mosip-sandbox-test --name console.sb
echo "console.sb started 1/7"
az vm start --resource-group mosip-sandbox-test --name mzmaster.sb
echo "mzmaster.sb started 2/7"
az vm start --resource-group mosip-sandbox-test --name mzworker0.sb
echo "mzworker0.sb started 3/7"
az vm start --resource-group mosip-sandbox-test --name mzworker1.sb
echo "mzworker1.sb started 4/7"
az vm start --resource-group mosip-sandbox-test --name mzworker2.sb
echo "mzworker2.sb started 5/7"
az vm start --resource-group mosip-sandbox-test --name dmzmaster.sb
echo "dmzmaster.sb started 6/7"
az vm start --resource-group mosip-sandbox-test --name dmzworker0.sb
echo "dmzworker0.sb started 7/7"
