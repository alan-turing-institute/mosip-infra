#!/bin/sh

# automates deployment and adds hostsnames.
# assumes azure cli

# permissions
chmod u+x ./scripts/hostfiles.sh
chmod u+x ./scripts/deallocate_vms.sh
chmod u+x ./scripts/startup_vms.sh

echo "DEPLOYING ON AZURE"
terraform init
terraform apply
echo "DEPLOYMENT FINISHED"
echo "AMENDING HOSTFILES"
./scripts/hostfiles.sh
