## MOSIP Terraform Script for VM Setup
### Introduction
We are using terraform script to create desired environment.

These instructions will take you through installing Terraform and Azure CLI, then it will describe how to edit the MOSIP files in order for terraform to deploy the environment correctly. 

### How does terraform work?
 Terraform is a tool for building, changing, and versioning infrastructure safely and efficiently. Which works as Infrastructure as code (IAC).

Generally, terraform communicates azure portal to create the resources through Azure CLI is interface of Terraform and Azure Portal.
                                                     
<img width="388" alt="terraform" src="https://user-images.githubusercontent.com/58170816/84351992-19113600-abda-11ea-9bec-b555e79d228e.PNG">
                                                                                                     
                                      
### Pre-requisites:
1.	Terraform utility
2.	Azure CLI
3.	Azure Portal Access

### Step 1: Install Terraform
1.	Create the directory with the following command: **mkdir terraform && cd terraform**
2.	Then, download Terraform using this command: **wget https://releases.hashicorp.com/terraform/0.12.26/terraform_0.12.26_linux_amd64.zip**
3.	Install a program called ‘unzip’ in order to unpack the download by entering the following: **sudo yum install unzip**
4.	Once installed, unpack the Terraform download: **unzip terraform_0.12.26_linux_amd64.zip**
5.	Set the Linux path to point to Terraform with the following command: export **PATH=$PATH:$HOME/terraform**
6.	Test that Terraform is installed by typing this command: **terraform –v**

 ![terraform-version](https://user-images.githubusercontent.com/58170816/84352547-2da1fe00-abdb-11ea-8336-8f15e21898e1.png)
 
7. Please verify, whether the latest **12.26 version** is installed. if not, use the below command to install **tfswitch**

**sudo curl -L https://raw.githubusercontent.com/warrensbox/terraform-switcher/release/install.sh | bash**

8. use **tfswitch** command to install the latest

<img width="369" alt="tfswitch" src="https://user-images.githubusercontent.com/58170816/84386299-b4240300-ac0e-11ea-98d7-215d84ea45f9.PNG">

9. Install the lastet **tfswitch version** by selecting the latest and enter like below.

<img width="361" alt="tfswitch-install" src="https://user-images.githubusercontent.com/58170816/84379398-5c33cf00-ac03-11ea-8cc2-cbeb12fca3df.PNG">

7. you just check whether it is 12.26 version. if no, install this.

**sudo curl -L https://raw.githubusercontent.com/warrensbox/terraform-switcher/release/install.sh | bash**

8. use **tfswitch** command to check the version like below

<img width="369" alt="tfswitch" src="https://user-images.githubusercontent.com/58170816/84379078-e16ab400-ac02-11ea-8b93-7f8ee651d3af.PNG">

9. select the latest one **12.26 version** and enter it will install with the latest one.

<img width="361" alt="tfswitch-install" src="https://user-images.githubusercontent.com/58170816/84379398-5c33cf00-ac03-11ea-8cc2-cbeb12fca3df.PNG">

### Step 2: Azure CLI installation
### 1.	Azure CLI installation for Ubuntu
       
  **curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash**

### 2.	Azure CLI installation for Linux

  **curl -L https://aka.ms/InstallAzureCli | bash**
  
  
### Step 3: Edit MOSIP files to allow for Azure Terraform deployment

There are a number of hardcoded variables in the MOSIP repository that need altering to your requires. For understanding we will step through the manual alterations. However, we also provide a script provided a script, `turing_azure_edits.sh`, that automates the process, so you can skip ahead if you would rather (recommended). The steps to manually alter the files are as follows:


#### Manual
- Terraform automatically picks up inputs from `variables.tf` to deploy the infrastructure. Some variables will need updating to your setup:
    - Azure subscription ID
    - admin password
    - domain name label (Azure DNS name)
    - NB: the Azure resource group name must *not* already exist.

- In addition to the above changes to `variables.tf`, we need to make sure all resources are pointing to the same region. The location is specified in multiple files and in different ways. Take the following steps:
    - In `variables.tf` change `location` to your azure region (e.g. from `"South India"` to `"UK South"`). Note the string syntax as Title Case instead of lowercase (e.g. `"southindia"`). 
    - For each resource in `vm.tf`, `nic.tf`, and `vnet.tf`, there is a `location` field. This is often hardcoded as `"southindia"`. All instances should be set to `location = var.location` or your azure region so it picks it up automatically from the variables file. The string case type at this step does not seem to matter since Azure recognises Title Case as Azure regions.
    - In `vm.tf` each virtual machine resource has a field `connection {host = ${var.domain_name_label}.southindia.cloudapp.azure.com}`.  The host needs to be changed to our location so that all resources are consistent, but crucially at this stage the string case *needs to be lowercase*. To resolve the discrepancy we create a new variable in `variables.tf`: `variable "locationlc" {default = "uksouth"}`. This then enables us to insert the variable into all the host strings as follows: `connection{host = ${var.domain_name_label}.${var.locationlc}.cloudapp.azure.com`.

- MOSIP have hardcoded many '.sb' extensions, which may be appropriate for aws but is not appropriate for azure. In `mosip-infra/deployment/sandbox-v2/hosts.ini`, `mosip-infra/deployment/sandbox-v2/group_vars/mzcluster.yml`, `mosip-infra/deployment/sanbox-v2/playbooks/mzcluster.yml`, `mosip-infra/deployment/sanbox-v2/group_vars/dmzcluster.yml`, and `mosip-infra/deployment/sandbox-v2/playbooks/dmzcluster.yml` we need to remove all '.sb' extensions.

#### Automated

We have provided a script to automate the above changes. You can find it in `mosip-infra/deployment/sandbox-v2/turing_azure_edits.sh`.

The script will prompt for user input specifying:   
    - Azure subscription ID.  
    - admin password.  
    - domain name label (Azure DNS name).  
    - Azure region (in Title Case).   

If you have made a typo, you should be able to run the script again specifying the correct variable. 

To run, we assume you have the repository cloned. Since the file alters itself when it runs it's prudent to create a copy and run the copy instead:

```
$ cd ~
$ cd mosip-infra/deployment/sandbox-v2
$ cp ./turing_azure_edits.sh ./turing_azure_edits_copy.sh
$ chmod u+x ./turing_azure_edits_copy.sh
$ ./turing_azure_edits_copy.sh

```     

You can now progress to step 4.

### Step 4: Run commands to deploy infrastructure.

 1.	Once the **Azure CLI** is installed, enter **az login** command will provide a **URl and code** to authenticate with your account.

 ![az-login](https://user-images.githubusercontent.com/58170816/84352663-5e823300-abdb-11ea-857d-239135f1e4ec.png)

 2.	Once you authenticated, it will list all the subscription, which has granted access for your account.

![subscription](https://user-images.githubusercontent.com/58170816/84352764-8bcee100-abdb-11ea-8a4c-9ba67db53443.png)
 
 3.	After listed the subscription, we can enter **terraform init** command where terraform config modules are present. Which will download **all the latest plugins** for the terraform modules.

 ![terraform-init](https://user-images.githubusercontent.com/58170816/84352814-a3a66500-abdb-11ea-8ada-c194a7ed2aa6.png)


 4.	Run **terraform plan** command. If details are is successfully listed as below, terraform is able to communicate with Azure portal. Note that there may be a syntax warning that can be safely ignored. 

 ![terraform-plan](https://user-images.githubusercontent.com/58170816/84352913-d05a7c80-abdb-11ea-8d96-f6b8fe9e97ca.png)

 5. Run **terraform apply** command. If the instrastructre code is tweaked appropriately, `terraform apply` should create a resource group on azure with 30 records. 
 
 
**YOU CAN NOW RETURN TO THE MOSIP INSTALLATION INSTRUCTIONS [HERE](https://github.com/mosip/mosip-infra/tree/master/deployment/sandbox-v2).**

The below text is additional information that the Turing has left unchanged.

### Azure portal Access

•	We at least should have contributor access.
•	Using Subscription Id, we can create the resources.

### OS

**CentOS 7.7** on all machines.

## Hardware setup

### The following VMs are recommended:

•	**Kubernetes master:**

o	Number of VMs: 2
o	Configuration: 4 CPU, 8 GB RAM

•	**Kubernetes workers:**

o	Number of Vms: 4
o	Configuration: 4 CPU, 16 GB RAM

### Console

**Console machine:** 1 (2 CPU, 4 GB RAM)

### Console setup

**Console machine** is setup with below steps while creating via terraform.

The below steps are carried out through Terraform scripts.

•	Create **'mosipuser'** user.

•	Make **sudo password-less** for this user.

•	Console machine in the **same subnet as kuberntes** cluster machines.

•	Console machine is accessible with the public domain name (e.g. sandbox.mycompany.com)

•	Port **80, 443, 30090** (for postgres) is opened on the console for external access.

•	Changed **hostname** of console machine to console.

•	**Ansible, Git** installed on console machine.

•	**Tumx** installed on console machine.

•	**Firewalld** stopped and disabled in console machine.

•	Created **ssh keys** using ssh-keygen and placed them in ~/.ssh folder on console machine.

### For new VM addition:

•	We have to add new **hostnames in variables hostname** section and need to place that in vm.tf as parameter.

•	We have to create new resources for **NIC and IP** and need to place the **NIC & IP** resources in to **vm.tf** config file.

•	If you want to change the attributes such as **username, password, ssh_key, resource group, location, tags, storage account type, vm size, hostname, domain name label, prefix**, need to change those in **variables.tf** config file.

### For new port addition:

•	We have to create inbound or outbound rule in **nsg.tf** config file.

### How to convert **openssh private key** as .ppk:

**Open Putty key generator  Actions  Click on load to load the keys  save the private key as .ppk key.**

### How to convert .ppk to .pem:

**Step 1 –** First of all, install the putty tools on your Linux system using below command.

**sudo apt-get install putty-tools**

**Step 2 –** Now, convert the ppk file to pem file using **puttygen** command line tool.

**puttygen server1.ppk -O private-openssh -o server1.pem**

**Step 3 –** Change the .pem file permissions. Set the read-only permissions to the owner of the file, remove any permission to group and other. Otherwise ssh will refuse this key for use.

**chmod 400 server1.pem**

**Step 4 –** Finally, connect to your remote Linux server with ssh using this pem key.

**ssh -i server1.pem ubuntu@ipaddress**






