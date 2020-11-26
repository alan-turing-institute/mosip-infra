#!/bin/sh

# script to install MOSIP on vm
az vm run-command invoke -g mosip-sandbox-test -n console --command-id RunShellScript --scripts @install_mosip.sh
