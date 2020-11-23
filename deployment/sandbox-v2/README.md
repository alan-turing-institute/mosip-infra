# MOSIP Sandbox Installer

## Introduction

The sandbox runs on a multi Virtual Machine (VM) setup, and may be used for development and testing.

**REG TEAM:**
This branch adjusts the documentation for the REG team to quickly deploy the infrastructure on macOS. 
Quick deployment:
- Make sure the hardcoded variables in `deployment/sandbox-v2/turing_azure_edits.sh` are correct. The dns name and the resource group should NOT EXIST before deployment.
- Run `deployment/sandbox-v2/automated_MOSIP_deployment.sh` from your home directory. 
- The last command of `deployment/sandbox-v2/automated_MOSIP_deployment.sh` is `terraform apply`. You'll likely encounter a [well known](https://github.com/terraform-providers/terraform-provider-azurerm/issues/532) Error:404 'Resource not found'. Re-run `terraform apply` in the directory `mosip-infra/deployment/sandbox-v2/terraform/azure` and it should work the second time.
- Next, install mosip by running `deployment/sandbox-v2/install_MOSIP_vm.sh` (NOT WRITTEN YET)


_**WARNING**: The sandbox is not intented to be used for serious pilots or production.  Further, do not run the sandbox with any confidential data._

_NB: In this fork The Alan Turing Institute have tweaked the installation instructions to improve clarity after deploying MOSIP using Azure. If you are deploying MOSIP using aws then you may want to follow the instructions in the original repository._ 

There are two broad phases to installing the sandbox:

1) Deploying the infrastructure using Terraform instructions found [here](https://github.com/alan-turing-institute/mosip-infra/tree/callummole-updatedocs/deployment/sandbox-v2/terraform/azure). These instructions will setup the VMs, which consists of a main _Console_ machine and additional workers. 

2) Installing MOSIP on the Console machine. 

For reference, the sandbox architecture is depicted below:

## Sandbox architecture
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

```
$ cd ~/
$ git clone https://github.com/mosip/mosip-infra
$ cd mosip-infra/deployment/sandbox-v2
``` 

* Exchange ssh keys with all machines. Provide the password for 'mosipuser'.
```
$ ./key.sh hosts.ini
``` 
 

##  Installing MOSIP 
### Site settings
In `group_vars/all.yml`, set the following: 
* Change `sandbox_domain_name`  to domain name of the console machine (e.g. `name.region.cloudapp.azure.com`)
* By default the installation scripts will try to obtain fresh SSL certificate for the above domain from [Letsencrypt](https://letsencrypt.org). However, If you already have the same then set the following variables in `group_vars/all.yml` file:
```
ssl:
  get_certificate: false
  email: ''
  certificate: <certificate dir>
  certificate_key: <private key path> 
```
* Set **private ip** address of `mzworker0` and `dmzworker0` in `group_vars/all.yml`:

```
clusters:
  mz:
    any_node_ip: '<mzworker0 ip>'

clusters:
  dmz:
    any_node_ip: '<dmzworker0 ip>'
```
### Network interface
If your cluster machines use network interface other than "eth0", update it in `group_vars/mzcluster.yml` and `group_vars/dmzcluster.yml`:
```
network_interface: "eth0"
```
### MOSIP configuration
Configure MOSIP as per [MOSIP Configuration Guide](docs/mosip_configuration_guide.md).

### Shortcut commands
Add the following shortcuts in `/home/mosipuser/.bashrc`:
```
alias an='ansible-playbook -i hosts.ini'
alias kc1='kubectl --kubeconfig $HOME/.kube/mzcluster.config'
alias kc2='kubectl --kubeconfig $HOME/.kube/dmzcluster.config'
alias sb='cd $HOME/mosip-infra/deployment/sandbox-v2/'
alias helm1='helm --kubeconfig $HOME/.kube/mzcluster.config'
alias helm2='helm --kubeconfig $HOME/.kube/dmzcluster.config'
```
After adding the above:
```
  $ source  ~/.bashrc
``` 
### Install MOSIP
* Intall all MOSIP modules:
```
$ ansible-playbook -i hosts.ini site.yml
```
or with shortcut command
```
$ an site.yml
```

Note that you may have unreachable errors for mzworkers3 -> mzworkers8. These can be ignored.

**YOU SHOULD NOW HAVE INSTALLED MOSIP**

## Dashboards
The links to various dashboards are available at 

```
https://<sandbox domain name>/index.html
```
Tokens/passwords to login into dashboards are available at `/tmp/mosip` of the console.

For Grafana you may import chart `11074`.

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
* Postgres is initialized and populated only once.  If persistent data is present in `/srv/nfs/mosip/postgres` then postgres is not initialized. You will need to run reset scripts to clear up the folder for a re-initialization.
* Postgres also contains Keycloak data.  `keycloak-init` does not overwrite any data, but just updates and adds.  If you want to clean up Keycloak data, you will need to clean it up manually or reset entire postgres.

## Useful tools
* If you use `tmux` tool, copy the config file as below:
```
$ cp /utils/tmux.conf ~/.tmux.conf  # Note the "."
```
