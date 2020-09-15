#!/bin/sh

#this program edits all the hardcoded MOSIP variables to work with azure deployment.
#stick this file in your sandbox-v2 root folder.
#in terminal navigate to mosip-infra root folder and enter 'chmod u+x turing_azure_edits.sh' so the user has permissions to run the shell script
#enter ./turing_azure_edits.sh
#note that the changes will also happen to this file. So if you make a mistake in the region you can just run the script again and enter the correct region

#STEP 1 change files in variables.tf
read -p "Azure Subscription ID: " subid
sed -i "" "3s/834c8af0-effa-4ca8-8bb6-1c499c21a323/$subid/" ./terraform/azure/variables.tf
echo "updated Azure subscription id"

read -p "Admin Password: " adm
sed -i "" "20s/Password@123/$adm/" ./terraform/azure/variables.tf
echo "updated password"

read -p "Domain name label (Azure DNS name): " dns
sed -i "" "12s/test-machine/$dns/" ./terraform/azure/variables.tf
echo "updated domain name"

#STEP 2 - change hardcoded regions
read -p "Azure Region (Title Case): " region
regionlc=${region// /} #remove whitespace
regionlc=$(echo "$regionlc" | tr A-Z a-z) #convert to lowercase
LC_CTYPE=C find ./ -type f -exec sed -i "" "s/My Region/$region/g" {} +
LC_CTYPE=C find ./ -type f -exec sed -i "" "s/myregion/$regionlc/g" {} +

echo "Changed all hardcoded title case and lowercase region entries"

#STEP 3 -delete unwanted file extensions from the desired files
sed -i "" "s/.sb//g" hosts.ini
sed -i "" "s/.sb//g" ./group_vars/mzcluster.yml
sed -i "" "s/.sb//g" ./group_vars/dmzcluster.yml
sed -i "" "s/.sb//g" ./playbooks/mzcluster.yml
sed -i "" "s/.sb//g" ./playbooks/dmzcluster.yml
sed -i "" "s/.sb//g" ./group_vars/all.yml

echo "deleted unwanted file extensions"
