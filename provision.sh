#!/bin/sh

sudo apt-get install software-properties-common
sudo apt-add-repository ppa:ansible/ansible
sudo apt update
sudo apt upgrade
sudo apt-get install ansible -y
# sudo apt-get install tree -y