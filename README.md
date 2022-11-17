# IaC

---
![Alt text](/images/ansiblediagram.png)

---

### What is IaC?

 Infrastructure as code is the process of managing and provisioning computer data centers through machine-readable definition files, rather than physical hardware configuration or interactive configuration tools.

 Infrastructure as code (IaC) means to manage your IT infrastructure using configuration files.
### What is Configuration Management?

Configuration management occurs when a configuration platform is used to automate, monitor, design and manage otherwise manual configuration processes. System-wide changes take place across servers and networks, storage, applications, and other managed systems.
### What is Orchestration?

Orchestration is the automated configuration, management, and coordination of computer systems, applications, and services. Orchestration helps IT to more easily manage complex tasks and workflows.

### What is Ansible?

Ansible is an open sourceIT automation tool that automates provisioning, configuration management, application deployment, orchestration, and many other manual IT processes.

### Benefits

- Agentless


### IP'S

- 192.168.56.11 - CONTROLLER
- 192.168.56.12 - WEB
- 192.168.56.13 - DB

### How to set up Controller connection between web and db nodes

in controller vm

**remember to ssh into the other vms before trying to run commands**

`sudo apt-get install software-properties-common`

`sudo apt-add-repository ppa:ansible/ansible`

then `sudo apt update`

then `sudo apt-get install ansible -y`

then `sudo apt-get install tree -y`

then `cd /etc`

then `cd ansible/`

then `sudo ssh vagrant@[ip of vm]`

password `vagrant`



in `vagrant@controller:/etc/ansible$`
1. run `sudo nano hosts`
2. add ip of web under `[web]` after ip add `ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant`
3. e.g `[web]`
`192.168.56.12 ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant`
4. run `sudo ansible -m ping web`

adhoc commands 
- `sudo ansible web -a "date"` - get the date of your `web` machine
- `sudo ansible all -m ping` - see which vms are connected
- `sudo ansible all -a "sudo apt update"` - update all vms
- `sudo ansible all -a "free"` - see the space on the vms connected

to copy file from controller to agent node run `sudo ansible web -m copy -a "src=hosts dest=/home/vagrant"`

to create a script i made a `provision.sh` file and saved in th esame location as the `Vagrantfile` and then i added this line `controller.vm.provision "shell", path: "provision.sh", privileged: false` to the Vagrant file. I then done `vagrant destroy` and then `vagrant up`

`-m` means module
`-a` means argument

### Yaml introduction 

in `vagrant@controller:/etc/ansible$`
  1. `sudo nano configure_nginx.yml`
  2. `---` shows that it is a yaml file
  3. `hosts` states the name of the server
  4. `gather_facts` states if you want to gather data
  5. `become` states whether you want admin sudo access
  6. `tasks` states the tasks you want to run
  7. to run the script run  `sudo ansible-playbook [name of playbook]`
  8. run `sudo ansible-playbook configure_nginx.yml -vvv` to see all detailed information

**configure_nginx.yml**
```yaml

# yaml file start
---
# create a script to configure nginx in our web server

# Who is the host - means name of the server
- hosts: web

# gather data
  gather_facts: yes

# we need admin access
  become: true

# add the actual instruction
  tasks:
  - name: install/configure Nginx web server in web-VM
    apt: pkg=nginx state=present
# we need to ensure at the end of this script the status of nginx is running

```

- Here is the mongodb playbook [mongo]((https://github.com/Subzy132/eng130-IaC/blob/main/mongo.yml))
- Here is the Node playbook [node]([l(https://github.com/Subzy132/eng130-IaC/blob/main/node.yml)])

### Moving to Hybrid 

prerequisites

- sudo apt install python3
- sudo apt install python3-pip
- pip3 install awscli
- pip3 install boto boto3
- python --version
- alias python=python3
- sudo mkdir group_vars
- cd group_vars/
- sudo mkdir all
- cd all/
- sudo ansible-vault create pass.yml
- add aws_access_key:
- add aws_secret_key:
- 


vi commands

- run `sudo vi test`
- :wq!
- sudo chmod 666 pass.yml
- create ssh key in controller
- sudo ansible-playbook ec2.yml --ask-vault-pass --tags create_ec2
- ec2-instance ansible_host=ec2-ip ansible_user=ubuntu ansible_ssh_private_key_file~/.ssh/eng130.pem in hosts
- 
- 

### Notes

- If you run into an error when downloading dependencies using the playbook you can use `sudo apt-get purge [name]` to delete a dependancy
  

to sync app to vm run this in the local host

`scp -r /Users/subhaanadmin/eng130-IaCnew/app vagrant@192.168.56.11:/home/vagrant`

`scp -r /Users/subhaanadmin/eng130-IaCnew/environment vagrant@192.168.56.11:/home/vagrant`
### What is Blue Green Deployment?

![Alt text](/images/bluegreen.png.jpeg)

Blue Green deployement is a release model the changes the traffic of users so that the organisation can update and ugrade their app wihtout causing a downtime. The users may be directed to an older version of the application while they work on the new version then the organisation gradually switches over to the new version making the old version a template or to be used as standby. 

the old version is called the blue environment and the new one is called the green environment

### Benefits

- Zero impact to users
- More Stability
- Zero Downtime
- Save money on cloud

### What is Inventory?

The Ansible inventory file defines the hosts and groups of hosts upon which commands, modules, and tasks in a playbook operate. The file can be in one of many formats depending on your Ansible environment and plugins. Common formats include INI and YAML.

### What is Ansible Roles?

Ansible roles allow you to develop reusable automation components by grouping and encapsulating related automation artifacts, like configuration files, templates, tasks, and handlers. Because roles isolate these components, it's easier to reuse them and share them with other people.

### Infrastructure as Code - Orchestration with Terraform

### What is Terraform

It is an Open source IaC tool, used by devops teams to automate infrastructure tasks. 

### Benefits 

Flexibility - Terraform can store local variables, including passwords and cloud tokens on Terraform registry in encrypted form

Portability - Terraform liberates you from the stress of switching providers regularly. Now you can use one language and one tool to define the infrastructure for AWS, Google Cloud, OpenStack, etc.

Not agent-based - Another appealing feature of Terraform is that it does not need to install any software on the managed infrastructure. Moreover, most of the automation and IaC tools are agent-based, but Terraform liberates its users from this hassle. 

Collaboration - Terraform’s central registry allows users to collaborate with other teams and individuals on infrastructure. 

### use cases

- Provisioning cloud resources
- Facilitate multi-cloud deployments
- deploying, managing, and orchestrating resources with custom cloud providers
### who is using it 

Uber.
Udemy.
Robinhood.
Slack.
Twitch.

### who owns it

Hashicorp -  software company that provides modular DevOps infrastructure provisioning and management products

### Installation guide for terraform

1. went to https://developer.hashicorp.com/terraform/downloads and downloaded the correct version
2. Found `/usr/local/bin` file and then dragged the downloaded binary file into there
3. Run terraform --version
4. restart terminal
5. create ENV VAR using `nano ~/.bashrc` and put `export AWS_ACCESS_KEY_ID=` and `export AWS_SECRET_KEY_ID=` 
6. run `source .bashrc`
7. run `nano main.tf`
```terraform
# Write a script to launch resources on the cloud

# create ec2 instance on AWS

# syntax {
#         ami = sdjagogi }
# download dependencies from AWS

provider "aws" { 


# which part of AWS we would like to launch resources in
  region = "eu-west-1"
}

resource "aws_instance" "app_instance" {
  ami = "ami-0b47105e3d7fc023e"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  tags = {
      Name = "eng130-subhaan-terraform-app"
 }
}
# what type of server with what sort of functionality 

# add resource

# ami

# instance type

# do we need public ip or not

# name the server 
``` 
8. run `terraform init`
9. run `terraform plan`
10. run `terraform apply`

![Alt text](/images/terraformdiagram.png)
