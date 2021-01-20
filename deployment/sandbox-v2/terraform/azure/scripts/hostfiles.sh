#!/bin/bash

# script to add entry to hostfile
rg=mosip-sandbox-test

az account set -s a8604fcd-7cc8-4801-a975-a4b777a179a4

for node in mzmaster.sb mzworker0.sb mzworker1.sb mzworker2.sb dmzmaster.sb dmzworker0.sb
do
    az vm run-command invoke -g $rg -n $node --command-id RunShellScript --scripts "sudo echo '10.20.20.10 console.sb' >> /etc/hosts"
    echo "added console.sb to /etc/hosts on $node" 
done
