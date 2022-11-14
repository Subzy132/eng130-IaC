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

### Requirements

in controller 

`sudo apt-get install software-properties-common`

`sudo apt-add-repository ppa:ansible/ansible`

then `sudo apt update`

then `sudo apt-get install ansible -y`

then `sudo apt-get install tree -y`

then `cd etc/`

then `cd ansible/`

then `sudo ssh vagrant@[ip of vm]`

password `vagrant`



in `vagrant@controller:/etc/ansible$`
1. run `sudo nano hosts`
2. add ip of web under `[web]` after ip add `ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant`
3. e.g `[web]`
192.168.56.12 ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=$`
4. run `sudo ansible -m ping web`



### What is Blue Green Deployment?

![Alt text](/images/bluegreen.png.jpeg)

Blue Green deployement is a release model the changes the traffic of users so that the organisation can update and ugrade their app wihtout causing a downtime. The users may be directed to an older version of the application while they work on the new version then the organisation gradually switches over to the new version making the old version a template or to be used as standby. 

the old version is called the blue environment and the new one is called the green environment

### Benefits

- Zero impact to users
- More Stability
- Zero Downtime
- Save money on cloud




