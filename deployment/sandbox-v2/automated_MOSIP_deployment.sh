#!/bin/sh

# for automated deployment of mosip infrastructure on a mac
#pre-requisits
echo "STEP 1: INSTALLING PRE-REQUISITES TERRAFORM AND AZURE-CLI"
brew install terraform
brew install azure-cli
#hard-coded edits
echo "STEP 2: CORRECTING HARDCODED EDITS"
cd ~
git clone https://github.com/alan-turing-institute/mosip-infra/
cd mosip-infra
git checkout simple-mac-deploy-1.1.2
cd deployment/sandbox-v2
chmod u+x ./turing_azure_edits.sh
./turing_azure_edits.sh
# azure terraform deployment
chmod u+x ./install_MOSIP_vm.sh
chmod u+x ./startup_vms.sh
chmod u+x ./stop_vms.sh

echo "STEP 3: AZURE TERRAFORM DEPLOYMENT"
az login
cd terraform/azure
terraform init
terraform plan
echo "RUNNING TERRAFORM APPLY, EXPECT ERROR 404 AND RUN AGAIN"
terraform apply
