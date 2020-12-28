### Create Azure Side Resources ###

#Deploy vNet
az network vnet create \
    --resource-group [sandbox resource group name] \
    --name Azure-VNet-1 \
    --address-prefix 10.0.0.0/16 \
    --subnet-name Services \
    --subnet-prefix 10.0.0.0/24

#Deploy Gateway Subnet
az network vnet subnet create \
    --resource-group [sandbox resource group name] \
    --vnet-name Azure-VNet-1 \
    --address-prefix 10.0.255.0/27 \
    --name GatewaySubnet

#Deploy local network gateway
az network local-gateway create \
    --resource-group [sandbox resource group name] \
    --gateway-ip-address 94.0.252.160 \
    --name LNG-HQ-Network \
    --local-address-prefixes 172.16.0.0/16

# Verify network have been created
az network vnet list --output table

# Verify local network gateways are created
az network local-gateway list \
    --resource-group [sandbox resource group name] \
    --output table