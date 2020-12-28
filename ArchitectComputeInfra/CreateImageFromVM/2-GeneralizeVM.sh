### Generalize the virtual machine ###

#SSH to VM
ssh -o StrictHostKeyChecking=no 137.135.47.217

#Prepare VM for generalization
sudo waagent -deprovision+user

#Deallocate VM
az vm deallocate \
    --name MyUbuntuVM

#Generalize VM
az vm generalize \
    --name MyUbuntuVM

