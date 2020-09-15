#!/bin/sh

#this program edits all the hardcoded MOSIP variables to work with azure deployment.
#stick this file in your mosip-infra root folder.
#in terminal navigate to mosip-infra root folder and enter 'chmod u+x mosip_azure_edits.sh' so the user has permissions to run the shell script
#enter ./mosip_azure_edits.sh
#note that the changes will also happen to this file. So if you make a mistake in the region you can just run the script again and enter the correct region

#STEP 1 - change hardcoded regions
read -p "Azure Region (Title Case): " region
regionlc=${region// /} #remove whitespace
regionlc=$(echo "$regionlc" | tr A-Z a-z) #convert to lowercase
LC_CTYPE=C find ./ -type f -exec sed -i "" "s/South India/$region/g" {} +
LC_CTYPE=C find ./ -type f -exec sed -i "" "s/southindia/$regionlc/g" {} +

echo "Changed all hardcoded title case and lowercase region entries"

#STEP 2 -delete  from everything, even the aws directory. NOTE will have to reset repo if want to deploy aws
LC_CTYPE=C find ./ -type f -exec sed -i "" "s/.sb//g" {} +

echo "deleted unwanted file extensions"
