### Create VM Image

az image create \
    --name MyVMIMage \
    --source MyUbuntuVM


#Create VM from image
az vm create \
  --name MyVMFromImage \
  --computer-name MyVMFromImage \
  --image MyVMImage \
  --admin-username azureuser \
  --generate-ssh-keys

#Update default webpage with server name
az vm extension set \
    --publisher Microsoft.Azure.Extensions \
    --name CustomScript \
    --vm-name MyVMFromImage \
    --settings '{"commandToExecute":"hostname > /var/www/html/index.html"}'

#Open port 80 on new VM
az vm open-port \
    --name MyVMFromImage \
    --port 80

#Find public IP
echo http://$(az vm list-ip-addresses \
                --name MyVMFromImage \
                --query "[].virtualMachine.network.publicIpAddresses[*].ipAddress" \
                --output tsv)