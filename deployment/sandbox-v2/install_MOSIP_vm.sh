#!/bin/sh

# script to install MOSIP on vm
cd ~/
git clone https://github.com/alan-turing-institute/mosip-infra
cd mosip-infra
git checkout simple-mac-deploy-1.1.2
cd deployment/sandbox-v2
./key.sh hosts.ini
./preinstall.sh
$ source ~/.bashrc
an site.yml
