#!/bin/sh

# script to start up vms.
az account set -s a8604fcd-7cc8-4801-a975-a4b777a179a4
az vm stop --resource-group mosip-sandbox-test --name console
az vm stop --resource-group mosip-sandbox-test --name mzmaster
az vm stop --resource-group mosip-sandbox-test --name mzworker0
az vm stop --resource-group mosip-sandbox-test --name mzworker1
az vm stop --resource-group mosip-sandbox-test --name mzworker2
az vm stop --resource-group mosip-sandbox-test --name dmzmaster
az vm stop --resource-group mosip-sandbox-test --name dmzworker0
