#!/bin/sh

#this program edits all the hardcoded MOSIP variables to work with azure deployment.
#stick this file in your sandbox-v2 root folder.
#in terminal navigate to mosip-infra root folder and enter 'chmod u+x turing_azure_edits.sh' so the user has permissions to run the shell script
#enter ./turing_azure_edits.sh
#note that the changes will also happen to this file. So if you make a mistake in the region you can just run the script again and enter the correct region

#STEP 1 change files in variables.tf
#read -p "Azure Subscription ID: " subid
subid="a8604fcd-7cc8-4801-a975-a4b777a179a4"
sed -i "" "3s/834c8af0-effa-4ca8-8bb6-1c499c21a323/$subid/" ./terraform/azure/variables.tf
echo "updated Azure subscription id to $subid"

#read -p "Admin Password: " adm
adm="roli7219@ati"
sed -i "" "20s/Password@123/$adm/" ./terraform/azure/variables.tf
echo "updated password to $adm"

#read -p "Domain name label (Azure DNS name): " dns
dns="configure"
sed -i "" "12s/test-machine/$dns/" ./terraform/azure/variables.tf
echo "updated domain name to $dns"
 
#read -p "Domain name label (Azure DNS name): " dns
rgroup="mosip-sandbox-updatedocs"
sed -i "" "31s/test-today/$rgroup/" ./terraform/azure/variables.tf
echo "updated resource group to $rgroup"

#STEP 2 - change hardcoded regions
#read -p "Azure Region (Title Case): " region
region="UK South"
regionlc=${region// /} #remove whitespace
regionlc=$(echo "$regionlc" | tr A-Z a-z) #convert to lowercase
LC_CTYPE=C find ./ -type f -exec sed -i "" "s/South India/$region/g" {} +
LC_CTYPE=C find ./ -type f -exec sed -i "" "s/uksouth/$regionlc/g" {} +

echo "Changed all hardcoded title case and lowercase region entries to $region or $regionlc"

#STEP 3 -delete unwanted file extentions from everything. NOTE will have to reset repo if want to deploy aws.
LC_CTYPE=C find ./ -type f -exec sed -i "" "s///g" {} +

echo "deleted unwanted file extensions"
