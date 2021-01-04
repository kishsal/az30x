```azurecli
RG=learn-e3f5d6a7-814d-47fd-9db1-d27cf0b213ca


az group create --name $RG --location westus2
```

#Create vNet
az network vnet create \
  --resource-group $RG \
  --name vehicleAppVnet \
  --address-prefix 10.0.0.0/16 \
  --subnet-name webServerSubnet \
  --subnet-prefix 10.0.1.0/24

#Clone repo to deploy VMs
git clone https://github.com/MicrosoftDocs/mslearn-load-balance-web-traffic-with-application-gateway module-files

#Deploy VMs
az vm create \
  --resource-group $RG \
  --name webServer1 \
  --image UbuntuLTS \
  --admin-username azureuser \
  --generate-ssh-keys \
  --vnet-name vehicleAppVnet \
  --subnet webServerSubnet \
  --public-ip-address "" \
  --nsg "" \
  --custom-data module-files/scripts/vmconfig.sh \
  --no-wait


az vm create \
  --resource-group $RG \
  --name webServer2 \
  --image UbuntuLTS \
  --admin-username azureuser \
  --generate-ssh-keys \
  --vnet-name vehicleAppVnet \
  --subnet webServerSubnet \
  --public-ip-address "" \
  --nsg "" \
  --custom-data module-files/scripts/vmconfig.sh

#Confirm VM creation
az vm list \
  --resource-group $RG \
  --show-details \
  --output table