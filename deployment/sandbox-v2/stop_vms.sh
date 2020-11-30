#!/bin/sh

# script to start up vms.
az account set -s a8604fcd-7cc8-4801-a975-a4b777a179a4
az vm stop --resource-group mosip-sandbox-test --name console
echo "console stopped 1/7"
az vm stop --resource-group mosip-sandbox-test --name mzmaster
echo "mzmaster stopped 2/7"
az vm stop --resource-group mosip-sandbox-test --name mzworker0
echo "mzworker0 stopped 3/7"
az vm stop --resource-group mosip-sandbox-test --name mzworker1
echo "mzworker1 stopped 4/7"
az vm stop --resource-group mosip-sandbox-test --name mzworker2
echo "mzworker2 stopped 5/7"
az vm stop --resource-group mosip-sandbox-test --name dmzmaster
echo "dmzmaster stopped 6/7"
az vm stop --resource-group mosip-sandbox-test --name dmzworker0
echo "dmzworker0 stopped 7/7"
