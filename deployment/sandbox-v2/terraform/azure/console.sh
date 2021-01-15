#!/bin/bash
#need to change this to console machine password to execute all commands before running the terraform script.
PW=Password@123

echo "------------ Generating the SSH-Key on Console Machine -------------"

ssh-keygen -b 2048 -t rsa -f ~/.ssh/id_rsa -q -N ''

echo " ------------- Installing Ansible on Console Machine ---------------"

echo "$PW" | sudo -E -S yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
echo $PW | sudo yum install ansible -y

echo "------------- Installing GIT on Console Machine ------------"

echo $PW | sudo yum install -y git

echo "-------------- Disabling FirewallD -----------------"

echo $PW | sudo systemctl stop firewalld
echo $PW | sudo systemctl disable firewalld 

echo "------------------- Injecting Aliases ----------------------------"

echo "###################################################################################################" >> $HOME/.bashrc
echo "# Aliases" >> $HOME/.bashrc
echo "###################################################################################################" >> $HOME/.bashrc
echo "alias an='ansible-playbook -i hosts.ini --ask-vault-pass -e @secrets.yml'" >> $HOME/.bashrc
echo "alias av='ansible-vault'" >> $HOME/.bashrc
echo "alias kc1='kubectl --kubeconfig $HOME/.kube/mzcluster.config'" >> $HOME/.bashrc
echo "alias kc2='kubectl --kubeconfig $HOME/.kube/dmzcluster.config'" >> $HOME/.bashrc
echo "alias sb='cd $HOME/mosip-infra/deployment/sandbox-v2/'" >> $HOME/.bashrc
echo "alias helm1='helm --kubeconfig $HOME/.kube/mzcluster.config'" >> $HOME/.bashrc
echo "alias helm2='helm --kubeconfig $HOME/.kube/dmzcluster.config'" >> $HOME/.bashrc
echo "alias helmm='helm --kubeconfig $HOME/.kube/mzcluster.config -n monitoring'" >> $HOME/.bashrc
echo "alias kcm='kubectl -n monitoring --kubeconfig $HOME/.kube/mzcluster.config'" >> $HOME/.bashrc
source  ~/.bashrc

echo "----------------- Adding Mosipuser to Sudoers file -------------------------"

sudo -i <<'EOF'
ls
echo "I am root now"
echo 'mosipuser ALL=(ALL)  NOPASSWD: ALL' >> /etc/sudoers
yum install tmux -y
mkdir -p ~/.ssh
touch ~/.ssh/authorized_keys
echo "-------------------- Copying mosipuser key to root --------------------------"
cat /home/mosipuser/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

chmod 755 /home/mosipuser # Needed for nginx access to display files
exit
EOF

# Old file system stuff if needed
# Partition disk to use the additional data.
# https://docs.microsoft.com/en-us/azure/virtual-machines/linux/attach-disk-portal
# CAUTION: the partition name is hardcoded. It may change.
### The previous code partitioned the drive but didn't mount it.
## see also https://blog.wacekdziewulski.ovh/2020/02/20/aws-cloudformation-mount-volume/

### ON further investigation the 128 gb disk is mounted in the same way as the default disk size is in the other vms.#
### So probably do not need to do below
#parted /dev/sdc --script mklabel gpt mkpart xfspart xfs 0% 100%
#mkfs.xfs /dev/sdc1
#partprobe /dev/sdc1
#mkdir /srv
#mount /dev/sdc1 /srv
#NEW_VOLUME_UUID=`lsblk /dev/sdc1 -n -o UUID`

#mkfs -t xfs /dev/nvme1n1
#mount /dev/nvme1n1 /srv
# Make the above permanent
#echo "/dev/sdc1 /srv                       xfs     defaults        0 0" >> /etc/fstab
#echo "UUID=${NEW_VOLUME_UUID}     /srv     xfs    defaults  0   0" >> /etc/fstab
         