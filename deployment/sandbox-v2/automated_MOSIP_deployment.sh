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
git checkout simple-mac-deploy
cd deployment/sandbox-v2
chmod u+x ./turing_azure_edits.sh
./turing_azure_edits.sh
# azure terraform deployment
echo "STEP 3: AZURE TERRAFORM DEPLOYMENT"
az login
cd terraform/azure
terraform init
terraform plan
terraform apply
