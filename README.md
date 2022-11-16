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

### Yaml introduction 

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

- Here is the mongodb playbook [mongo]([link](https://github.com/Subzy132/eng130-IaC/blob/main/mongo.yml))
- Here is the Node playbook [mongo]([link](https://github.com/Subzy132/eng130-IaC/blob/main/node.yml))

### Notes

- If you run into an error when downloading dependencies using the playbook you can use `sudo apt-get purge [name]` to delete a dependancy
- 

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






