# Create traffic manager profile
az network traffic-manager profile create \
    --resource-group learn-e3f5d6a7-814d-47fd-9db1-d27cf0b213ca \
    --name TM-MusicStream-Priority \
    --routing-method Priority \
    --unique-dns-name TM-MusicStream-Priority-$RANDOM

#Deploy web application
az deployment group create \
    --resource-group learn-e3f5d6a7-814d-47fd-9db1-d27cf0b213ca \
    --template-uri  https://raw.githubusercontent.com/MicrosoftDocs/mslearn-distribute-load-with-traffic-manager/master/azuredeploy.json \
    --parameters password="$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32)"

#Add endpoints to Traffic Manager
WestId=$(az network public-ip show \
    --resource-group learn-e3f5d6a7-814d-47fd-9db1-d27cf0b213ca \
    --name westus2-vm-nic-pip \
    --query id \
    --out tsv)

az network traffic-manager endpoint create \
    --resource-group learn-e3f5d6a7-814d-47fd-9db1-d27cf0b213ca \
    --profile-name TM-MusicStream-Priority \
    --name "Primary-WestUS" \
    --type azureEndpoints \
    --priority 1 \
    --target-resource-id $WestId

EastId=$(az network public-ip show \
    --resource-group learn-e3f5d6a7-814d-47fd-9db1-d27cf0b213ca \
    --name eastasia-vm-nic-pip \
    --query id \
    --out tsv)

az network traffic-manager endpoint create \
    --resource-group learn-e3f5d6a7-814d-47fd-9db1-d27cf0b213ca \
    --profile-name TM-MusicStream-Priority \
    --name "Failover-EastAsia" \
    --type azureEndpoints \
    --priority 2 \
    --target-resource-id $EastId


#View endpoints
az network traffic-manager endpoint list \
    --resource-group learn-e3f5d6a7-814d-47fd-9db1-d27cf0b213ca \
    --profile-name TM-MusicStream-Priority \
    --output table