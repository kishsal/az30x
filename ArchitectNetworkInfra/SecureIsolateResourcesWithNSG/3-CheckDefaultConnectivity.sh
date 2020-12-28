###   Check default connectivity ###

#List VM addresses
az vm list \
    --resource-group $rg \
    --show-details \
    --query "[*].{Name:name, PrivateIP:privateIps, PublicIP:publicIps}" \
    --output table

#Assign public IP addresses to variables
APPSERVERIP="$(az vm list-ip-addresses \
                 --resource-group $rg \
                 --name AppServer \
                 --query "[].virtualMachine.network.publicIpAddresses[*].ipAddress" \
                 --output tsv)"

DATASERVERIP="$(az vm list-ip-addresses \
                 --resource-group $rg \
                 --name DataServer \
                 --query "[].virtualMachine.network.publicIpAddresses[*].ipAddress" \
                 --output tsv)"

# Check if you can connect to AppServer
ssh azureuser@$APPSERVERIP -o ConnectTimeout=5

#Check if you can connect to DataServer
ssh azureuser@$DATASERVERIP -o ConnectTimeout=5

