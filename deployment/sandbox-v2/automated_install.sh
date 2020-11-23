#!/bin/sh

# for automated deployment of mosip infrastructure on a mac
#pre-requisits
echo "installing pre-requisites terraform and azure-cli"
brew install terraform
brew install azure-cli
#hard-coded edits
echo "correcting hardcoded edits"
cd ~
git clone https://github.com/alan-turing-institute/mosip-infra/
cd mosip-infra
git checkout simple-mac-deploy
cd deployment/sandbox-v2
chmod u+x ./turing_azure_edits.sh
./turing_azure_edits.sh
# azure terraform deployment
echo "azure terraform deployment"
az login
cd terraform/azure
terraform init
terraform plan
terraform apply

