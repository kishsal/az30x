### Optimize applications across regions by using performance routing  ###

#Create traffic manager with performance routing
az network traffic-manager profile create \
    --resource-group learn-e3f5d6a7-814d-47fd-9db1-d27cf0b213ca \
    --name TM-MusicStream-Performance \
    --routing-method Performance \
    --unique-dns-name TM-MusicStream-Performance-$RANDOM \
    --output table

#Create two new endpoints
WestId=$(az network public-ip show \
    --resource-group learn-e3f5d6a7-814d-47fd-9db1-d27cf0b213ca \
    --name westus2-vm-nic-pip \
    --query id \
    --out tsv)

az network traffic-manager endpoint create \
    --resource-group learn-e3f5d6a7-814d-47fd-9db1-d27cf0b213ca \
    --profile-name TM-MusicStream-Performance \
    --name "WestUS" \
    --type azureEndpoints \
    --target-resource-id $WestId

EastId=$(az network public-ip show \
    --resource-group learn-e3f5d6a7-814d-47fd-9db1-d27cf0b213ca \
    --name eastasia-vm-nic-pip \
    --query id \
    --out tsv)

az network traffic-manager endpoint create \
    --resource-group learn-e3f5d6a7-814d-47fd-9db1-d27cf0b213ca \
    --profile-name TM-MusicStream-Performance \
    --name "EastAsia" \
    --type azureEndpoints \
    --target-resource-id $EastId

#Test the new config
echo http://$(az network traffic-manager profile show \
    --resource-group learn-e3f5d6a7-814d-47fd-9db1-d27cf0b213ca \
    --name TM-MusicStream-Performance \
    --query dnsConfig.fqdn \
    --output tsv)

#Use nslookup to resolve Traffic Manager profile domain name
nslookup $(az network traffic-manager profile show \
        --resource-group learn-e3f5d6a7-814d-47fd-9db1-d27cf0b213ca \
        --name TM-MusicStream-Performance \
        --query dnsConfig.fqdn \
        --output tsv)

