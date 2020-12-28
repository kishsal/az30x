### Create the simulated on-premises network and supporting resources ###

# Create vNet and subnet
az network vnet create \
    --resource-group [sandbox resource group name] \
    --name HQ-Network \
    --address-prefix 172.16.0.0/16 \
    --subnet-name Applications \
    --subnet-prefix 172.16.0.0/24

# Create gateway subnet
az network vnet subnet create \
    --resource-group [sandbox resource group name] \
    --address-prefix 172.16.255.0/27 \
    --name GatewaySubnet \
    --vnet-name HQ-Network

#Create local network gateway
az network local-gateway create \
    --resource-group [sandbox resource group name] \
    --gateway-ip-address 94.0.252.160 \
    --name LNG-Azure-VNet-1 \
    --local-address-prefixes 10.0.0.0/16

# Verify network have been created
az network vnet list --output table

# Verify local network gateways are created
az network local-gateway list \
    --resource-group [sandbox resource group name] \
    --output table
