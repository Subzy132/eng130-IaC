#!/bin/bash
# updating and upgrading vm
sudo apt update
sudo apt upgrade -y
# installing ansible
sudo apt-get install software-properties-common
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible -y
sudo apt-get install tree
cd /etc/ansible
# write the hosts locations into the files for faster accessibility
echo [web] >> hosts
echo 192.168.56.12 ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant >> hosts
echo [db] >> hosts
echo 192.168.56.13 ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant >> hosts