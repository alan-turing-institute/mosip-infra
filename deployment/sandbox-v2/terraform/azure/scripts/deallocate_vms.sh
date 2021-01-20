#!/bin/bash

# script to deallocate vms.
#az vm deallocate --ids $(az vm list -g <resourcegroupname> --query "[].id" -o tsv)
az account set -s a8604fcd-7cc8-4801-a975-a4b777a179a4

rg=mosip-sandbox-test

for node in console.sb mzmaster.sb mzworker0.sb mzworker1.sb mzworker2.sb dmzmaster.sb dmzworker0.sb
do
    echo "deallocating $node ..."
    az vm deallocate --resource-group $rg --name $node 
    echo "$node deallocated" 
done
