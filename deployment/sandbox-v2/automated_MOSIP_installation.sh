#!/bin/sh

# script to install MOSIP on vm
./edit_MOSIP_files.sh
echo "RUNNING INSTALLATION ON MOSIP"
az vm run-command invoke -g mosip-sandbox-test -n console --command-id RunShellScript --scripts @install_MOSIP_vm.sh
