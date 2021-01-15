#!/bin/sh

# script to install MOSIP on vm
cd ~/
git clone https://github.com/alan-turing-institute/mosip-infra
cd mosip-infra
git checkout 1.1.3
cd deployment/sandbox-v2
cp $HOME/mosip-infra/deployment/sandbox-v2/utils/tmux.conf $HOME/.tmux.conf
./keys.sh hosts.ini
chmod u+x ./individual_playbooks.sh
./individual_playbooks.sh
#an site.yml
