#!/bin/sh

# script to start up vms.
az account set -s a8604fcd-7cc8-4801-a975-a4b777a179a4
az vm stop --resource-group mosip-sandbox-test --name console.sb
echo "console.sb stopped 1/7"
az vm stop --resource-group mosip-sandbox-test --name mzmaster.sb
echo "mzmaster.sb stopped 2/7"
az vm stop --resource-group mosip-sandbox-test --name mzworker0.sb
echo "mzworker0.sb stopped 3/7"
az vm stop --resource-group mosip-sandbox-test --name mzworker1.sb
echo "mzworker1.sb stopped 4/7"
az vm stop --resource-group mosip-sandbox-test --name mzworker2.sb
echo "mzworker2.sb stopped 5/7"
az vm stop --resource-group mosip-sandbox-test --name dmzmaster.sb
echo "dmzmaster.sb stopped 6/7"
az vm stop --resource-group mosip-sandbox-test --name dmzworker0.sb
echo "dmzworker0.sb stopped 7/7"
