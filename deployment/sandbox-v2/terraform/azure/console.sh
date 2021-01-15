#!/bin/bash
#need to change this to console machine password to execute all commands before running the terraform script.
PW=Password@123

echo "------------ Generating the SSH-Key on Console Machine -------------"

ssh-keygen -b 2048 -t rsa -f ~/.ssh/id_rsa -q -N ''

echo "------------- Installing GIT on Console Machine ------------"

echo $PW | sudo yum install -y git

echo "-------------- Disabling FirewallD -----------------"

echo $PW | sudo systemctl stop firewalld
echo $PW | sudo systemctl disable firewalld 


echo "----------------- Adding Mosipuser to Sudoers file -------------------------"

sudo -i <<'EOF'
ls
echo "I am root now"
echo 'mosipuser ALL=(ALL)  NOPASSWD: ALL' >> /etc/sudoers
yum install tmux -y
cp /utils/tmux.conf ~/.tmux.conf
mkdir -p ~/.ssh
touch ~/.ssh/authorized_keys
echo "-------------------- Copying mosipuser key to root --------------------------"
cat /home/mosipuser/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

exit
EOF


