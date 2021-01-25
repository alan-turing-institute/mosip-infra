# MOSIP Sandbox Installer

## Introduction

The sandbox runs on a multi Virtual Machine (VM) setup, and may be used for development and testing.

---

### REG TEAM
#### Deploy infrastructre from scratch
This branch contains hardcoded edits to deploy the minibox (3 mzcluster vms instead of 9) with the username 'mosipuser', domain 'mosipsb.uksouth.cloudapp.azure.com', and password 'roli7219@ati'.

```
git clone https://github.com/alan-turing-institute/mosip-infra
cd mosip-infra
git checkout 1.1.3
cd deployment/sandbox-v2/terraform/azure
terraform init
terraform apply

# also do the following if you are going to stop and start the cluster 
chmod u+x ./scripts/hostfiles.sh
./scripts/hostfiles.sh #adds console.sb private ip to the hosts file on all kubernetes machines so that the nfs server is found on reboot.
chmod u+x ./scripts/deallocate_vms.sh
chmod u+x ./scripts/startup_vms.sh
```

To install MOSIP onto the console: `ssh sandbox.uksouth.cloudapp.azure.com`, the copy and paste the following commands: 

```
# script to install MOSIP on vm
cd ~/
git clone https://github.com/alan-turing-institute/mosip-infra
cd mosip-infra
git checkout 1.1.3
cd deployment/sandbox-v2
cp $HOME/mosip-infra/deployment/sandbox-v2/utils/tmux.conf $HOME/.tmux.conf
./keys.sh hosts.ini  #swaps keys with cluster machines
chmod u+x ./individual_playbooks.sh 
./individual_playbooks.sh # runs each playbook with progress output and passing the vault password found in `vault_default.txt` (an site.yml is difficult to debug and  stops on an error).
#an site.yml
```

NOTE: The Vault password is 'foo'.

### Redeploying infrastracture.
If you want to freshly deploy the infrastructure you'll need to delete the resource group `mosip-sandbox-test` through the azure portal. Then delete the terraform state data in the existing `mosip-infra` clone, found in `terraform/azure/.terraform`, and also `terraform/azure/terraform.tfstate`. 

You'll also need to delete the `mosipsb.uksouth.cloudapp.azure.com` entry in the local known hosts file: `nano /Users/<usr>/.ssh/known_hosts`. After these steps you simply do `terraform init` then `terraform apply`. 

### Start and deallocate azure vms
From your local, run `mosip-infra/deployment/sandbox-v2/startup_vms.sh` to startup existing resources (this file also starts the nginx server on the console and disables swapoff on dmzmaster and mzmaster). At the end of the session run `mosip-infra/deployment/sandbox-v2/deallocate_vms.sh` to deallocate vms and avoid billing.

---



_**WARNING**: The sandbox is not intented to be used for serious pilots or production.  Further, do not run the sandbox with any confidential data._

_NB: In this fork The Alan Turing Institute have tweaked the installation instructions to improve clarity after deploying MOSIP using Azure. If you are deploying MOSIP using aws then you may want to follow the instructions in the original repository._ 

There are two broad phases to installing the sandbox:

1) Deploying the infrastructure using Terraform instructions found [here](https://github.com/alan-turing-institute/mosip-infra/tree/callummole-updatedocs/deployment/sandbox-v2/terraform/azure). These instructions will setup the VMs, which consists of a main _Console_ machine and additional workers. 

2) Installing MOSIP on the Console machine. 


## Hardware configuration

### Full sandbox
The sandbox has been tested with the following configuration:

| Component| Number of VMs| Configuration| Persistence |
|---|---|---|---|
|Console| 1 | 4 vCPU*, 16 GB RAM | 128 GB SSD**|
|K8s MZ master | 1 | 4 vCPU, 8 GB RAM | 32 GB|
|K8s MZ workers | 9 | 4 vCPU, 16 GB RAM | 32 GB |
|K8s DMZ master | 1 | 4 vCPU, 8 GB RAM | 32 GB |
|K8s DMZ workers | 1 | 4 vCPU, 16 GB RAM | 32 GB |

\* vCPU:  Virtual CPU  
\** Console has all the persistent data stored under `/srv/nfs`.  Recommended storage here is SSD or any other high IOPS disk for better performance.

### Minibox
It is possible to bring up MOSIP modules with lesser VMs as below.  However, do note that this may not be sufficient for any kind of load or multiple pod replication scenarios:

| Component| Number of VMs| Configuration| Persistence |
|---|---|---|---|
|Console| 1 | 4 vCPU*, 16 GB RAM | 128 GB SSD |
|K8s MZ master | 1 | 4 vCPU, 8 GB RAM | 32 GB |
|K8s MZ workers | 3 | 4 vCPU, 16 GB RAM | 32 GB |
|K8s DMZ master | 1 | 4 vCPU, 8 GB RAM | 32 GB |
|K8s DMZ workers | 1 | 4 vCPU, 16 GB RAM | 32 GB |

## Virtual Machines (VMs) setup

Before installing MOSIP modules you will have to set up your VMs as below:
1. Install above mentioned OS on all machines
1. Create user 'mosipuser' on console machine with password-less `sudo su`. 
1. `hostname` on all machines must match hostnames in `hosts.ini`.  Set the same with
    ```
    $ sudo hostnamectl set-hostname <hostname>
    ```
1. Enable Internet connectivity on all machines. 
1. Disable `firewalld` on all machines. 
1. Exchange ssh keys between console and K8s cluster machines such that ssh is password-less from console machine:
    ```  
    $[mosipuser@console.sb] ssh root@<any K8s node>
    $[mosipuser@console.sb] ssh mosipuser@console.sb
    ```  
1. Make console machine accessible via a public domain name (e.g. sandbox.mycompany.com).  This step may be skipped if you do not plan to access the sandbox externally. 
1. Make sure datetime on all machines is in UTC.
1. Open ports 80, 443, 30090 (postgres), 30616 (activemq), 53 (coredns) on console machine for external access.
1. DNS: Setup a DNS server (or use cloud provider's DNS) such that console and nodes are accessible via their domain names listed in `hosts.ini`.  It is important to check if domain names are resolved from within pods of K8s cluster.  One way to check is after the cluster is up, deploy `utils/busybox.yml` pod, login into the pod and run the command `ping mzworker0.sb`.  DO NOT use `/etc/hosts` for domain name resolution, as name resolution will fail from within pods if this method is followed.

## Terraform
All the above is achieved using Terraform scripts available in `terraform/`.  At present, AWS scripts are being used and maintained.  It is highly recommended that you study the scripts in detail before running them. 

# Sandbox architecture
![](https://github.com/mosip/mosip-infra/blob/master/deployment/sandbox-v2/docs/sandbox_architecture.png)

# Setting up the Sandbox Architecture on Azure

First we build the infrastructure. Begin on the local machine. Please follow the [Terraform instructions](https://github.com/alan-turing-institute/mosip-infra/tree/callummole-updatedocs/deployment/sandbox-v2/terraform/azure) before progressing any further. 

We assume that you have created the VMs using the [Terraform instructions](https://github.com/alan-turing-institute/mosip-infra/tree/callummole-updatedocs/deployment/sandbox-v2/terraform/azure). The last action before installing MOSIP is to share keys amongst all the hosts for password-less login. 

* ssh onto the console vm using the password that you have specified in `/terraform/azure/variables.tf`
```
$ ssh domainname
```

The Console machine should have ansible and git installed as part of the deployment (see `/terraform/azure/console.sh`). So you can probably safely skip to connecting cloning the repository below. If ansible and/or git are not installed follow the relevant instruction below:

* Install Ansible
```
$ sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
$ sudo yum install ansible
```
* Install git
```
$ sudo yum install -y git
```

* Git clone this repo in user home directory.


## Software prerequisites

* Install `git`:
```
$ sudo yum install -y git
```
* Git clone this repo in user home directory. Switch to the appropriate branch.  
```
$ cd ~/
$ git clone https://github.com/mosip/mosip-infra
$ cd mosip-infra
$ git checkout 1.1.2
$ cd mosip-infra/deployment/sandbox-v2
```
* Install Ansible and create shortcuts:
```
$ ./preinstall.sh
$ source ~/.bashrc
```

##  Installing MOSIP 
### Site settings
* Update `hosts.ini` as per your setup. Make sure the machine names are IP addresses match your setup. 
* In `group_vars/all.yml` change `sandbox_domain_name`  to domain name of the console machine (e.g. `name.region.cloudapp.azure.com`).

* By default the installation scripts will try to obtain fresh SSL certificate for the above domain from [Letsencrypt](https://letsencrypt.org). However, If you already have the same then set the following variables in `group_vars/all.yml` file:
```
ssl:
  get_certificate: false
  email: ''
  certificate: <certificate dir>
  certificate_key: <private key path> 
```

### Network interface
If your cluster machines use network interface other than "eth0", update it in `group_vars/k8s.yml`.
```
network_interface: "eth0"
```
### Ansible vault
All secrets (passwords) used in this automation are stored in Ansible vault file `secrets.yml`.  The default password to access the file is 'foo'.  It is recommended that you change this password with following command:
```
$ av rekey secrets.yml
```
You may view and edit the contents of `secrets.yml`:
```
$ av view secrets.yml
$ av edit secrets.yml
```

### MOSIP configuration
Configure MOSIP as per [MOSIP Configuration Guide](docs/mosip_configuration_guide.md).

### Install MOSIP
* Intall all MOSIP modules:
```
$ an site.yml
```
Provide the vault password.  Default is 'foo'.

Note that you may have unreachable errors for mzworkers3 -> mzworkers8. These can be ignored.

**YOU SHOULD NOW HAVE INSTALLED MOSIP**

## Dashboards
The links to various dashboards are available at 

```
https://<sandbox domain name>/index.html
```

Refer to [Dashboards Guide](docs/dashboards.md)

## Sanity checks

[Sanity checks](docs/sanity_checks.md) during and post deployment.

## Reset
To install fresh, you may want to reset the clusters and persistence data.  Run the below script for the same.  This is **dangerous!**  The reset script will tear down the clusters and delete all persistence data.  Provide 'yes/no' responses to the prompts:
```
$ an reset.yml
```

## Persistence
All persistent data is available over Network File System (NFS) hosted on the console at location `/srv/nfs/mosip`.  All pods write into this location for any persistent data.  You may backup this folder if needed.

Note the following:
* Postgres is initialized and populated only once.  If persistent data is present in `/srv/nfs/mosip/postgres` then postgres is not initialized.  To force an init, run the following:
```
$ an playbooks/postgres.yml --extra-vars "force_init=true"
``` 
* Postgres also contains Keycloak data.  `keycloak-init` does not overwrite any data, but just updates and adds.  If you want to clean up Keycloak data, you will need to clean it up manually or reset entire postgres.

## Useful tools
### Shortcut commands
The following shortcuts are installed with `preinstall.sh`.  These are quite helpful with command line operations.
```
alias an='ansible-playbook -i hosts.ini --ask-vault-pass -e @secrets.yml'
alias av='ansible-vault'
alias kc1='kubectl --kubeconfig $HOME/.kube/mzcluster.config'
alias kc2='kubectl --kubeconfig $HOME/.kube/dmzcluster.config'
alias sb='cd $HOME/mosip-infra/deployment/sandbox-v2/'
alias helm1='helm --kubeconfig $HOME/.kube/mzcluster.config'
alias helm2='helm --kubeconfig $HOME/.kube/dmzcluster.config'
alias helmm='helm --kubeconfig $HOME/.kube/mzcluster.config -n monitoring'
alias kcm='kubectl -n monitoring --kubeconfig $HOME/.kube/mzcluster.config'
```
After adding the above:
```
  $ source  ~/.bashrc
``` 
### Tmux
If you use `tmux` tool, copy the config file as below:
```
$ cp /utils/tmux.conf ~/.tmux.conf  # Note the "."
```
### Property file comparator
To compare two property files (`*.properties`) use:
```
$ ./utils/prop_comparator.py <file1> <file2>
```
