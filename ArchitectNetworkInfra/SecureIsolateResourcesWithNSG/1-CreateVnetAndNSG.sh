###  Create a virtual network and network security group ###

# find location name
az account list-locations -o table

#create RG
rg=learn-274a1913-3197-4f59-9554-c569f04b8e08

az group create --name $rg --location westus2

#Create vNet and Applications subnet
az network vnet create \
    --resource-group $rg \
    --name ERP-servers \
    --address-prefix 10.0.0.0/16 \
    --subnet-name Applications \
    --subnet-prefix 10.0.0.0/24

# Create databases subnet
az network vnet subnet create \
    --resource-group $rg \
    --vnet-name ERP-servers \
    --address-prefix 10.0.1.0/24 \
    --name Databases

# Create NSG
az network nsg create \
    --resource-group $rg \
    --name ERP-SERVERS-NSG