### Test the application

#Get DNS
# Retrieve the address for the West US 2 web app
nslookup $(az network public-ip show \
            --resource-group learn-e3f5d6a7-814d-47fd-9db1-d27cf0b213ca \
            --name westus2-vm-nic-pip \
            --query dnsSettings.fqdn \
            --output tsv)
# Retrieve the address for the East Asia web app
nslookup $(az network public-ip show \
            --resource-group learn-e3f5d6a7-814d-47fd-9db1-d27cf0b213ca \
            --name eastasia-vm-nic-pip \
            --query dnsSettings.fqdn \
            --output tsv)
# Retrieve the address for the Traffic Manager profile
nslookup $(az network traffic-manager profile show \
            --resource-group learn-e3f5d6a7-814d-47fd-9db1-d27cf0b213ca \
            --name TM-MusicStream-Priority \
            --query dnsConfig.fqdn \
            --out tsv)


#Go to Traffic Manager's profile FQDN and it's routed to highest priority
echo http://$(az network traffic-manager profile show \
    --resource-group learn-e3f5d6a7-814d-47fd-9db1-d27cf0b213ca \
    --name TM-MusicStream-Priority \
    --query dnsConfig.fqdn \
    --out tsv)

#Disable primary endpoint
az network traffic-manager endpoint update \
    --resource-group learn-e3f5d6a7-814d-47fd-9db1-d27cf0b213ca  \
    --name "Primary-WestUS" \
    --profile-name TM-MusicStream-Priority \
    --type azureEndpoints \
    --endpoint-status Disabled

#Let's look at the DNS entries
# Retrieve the address for the West US 2 web app
nslookup $(az network public-ip show \
            --resource-group learn-e3f5d6a7-814d-47fd-9db1-d27cf0b213ca \
            --name eastasia-vm-nic-pip \
            --query dnsSettings.fqdn \
            --output tsv)
# Retrieve the address for the East Asia web app
nslookup $(az network public-ip show \
            --resource-group learn-e3f5d6a7-814d-47fd-9db1-d27cf0b213ca \
            --name westus2-vm-nic-pip \
            --query dnsSettings.fqdn \
            --output tsv)
# Retrieve the address for the Traffic Manager profile
nslookup $(az network traffic-manager profile show \
            --resource-group learn-e3f5d6a7-814d-47fd-9db1-d27cf0b213ca \
            --name TM-MusicStream-Priority \
            --query dnsConfig.fqdn \
            --out tsv)

