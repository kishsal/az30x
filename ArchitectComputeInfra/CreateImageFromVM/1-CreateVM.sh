### Create VM

# set your default RG
az configure --defaults group=learn-286fd52e-2ef3-482e-8fa7-124e742b5ab0

#Create VM
az vm create \
    --name MyUbuntuVM \
    --image UbuntuLTS \
    --generate-ssh-keys

az vm open-port \
    --name MyUbuntuVM \
    --port 80

az vm extension set \
    --publisher Microsoft.Azure.Extensions \
    --name CustomScript \
    --vm-name MyUbuntuVM \
    --settings '{"commandToExecute":"apt-get -y update && apt-get -y install nginx && hostname > /var/www/html/index.html"}'

#Find the public IP
echo http://$(az vm list-ip-addresses \
             --name MyUbuntuVM \
             --query "[].virtualMachine.network.publicIpAddresses[*].ipAddress" \
             --output tsv)

