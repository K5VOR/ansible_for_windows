# ansible_for_windows
This project aims to created an easy to use ansible docker container on windows.  Included utilities will install Docker and setup all required environmental variables.

# installation
1. Copy your id_rsa file into the main folder.
2. Open a powershell window and navigate to the folder for this repo. run the following command
   `tools\setup`
   > This will install Docker if it isn't already install.

## Powershell Scripts
This program includes powershell scripts that wrap ansible and ansible-playbook for easy use. Instead of using

`docker-compose run --rm ansible ansible -m win_ping`

you use

`ansible -m win_ping`

All scripts start in the /etc/ansible directory of your docker container. Store your playbooks in the playbook etc/ansible/playbooks directory.  To use these you would use the following command:
  `ansible-playbook playbooks/my_playbook.yml`

#Playbooks
