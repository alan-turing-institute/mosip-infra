#!/bin/sh

# script to install MOSIP on vm
#./edit_MOSIP_files.sh
echo "RUNNING MOSIP INSTALLATION ON CONSOLE"
az vm run-command invoke -g mosip-sandbox-test -n console.sb --command-id RunShellScript --scripts @install_MOSIP_vm.sh
