#!/bin/sh

# script to install MOSIP on vm
cd ~/
git clone https://github.com/alan-turing-institute/mosip-infra
cd mosip-infra
git checkout 1.1.3
cd deployment/sandbox-v2
./keys.sh hosts.ini
./preinstall.sh
source ~/.bashrc
./individual_playbooks.sh
#an site.yml
