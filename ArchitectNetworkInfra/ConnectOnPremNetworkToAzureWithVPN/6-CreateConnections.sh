### Create the connections ###

# Create shared key
SHAREDKEY=A1Mhugn7gyIl/Tlq8Orol4HtOERkfqZA

# Create connection from VNG-Azure-VNet-1 to LNG-HQ-Network
az network vpn-connection create \
    --resource-group learn-274a1913-3197-4f59-9554-c569f04b8e08 \
    --name Azure-VNet-1-To-HQ-Network \
    --vnet-gateway1 VNG-Azure-VNet-1 \
    --shared-key $SHAREDKEY \
    --local-gateway2 LNG-HQ-Network

# Create connection from VNG-HQ-Network to LNG-Azure-VNet-1
az network vpn-connection create \
    --resource-group learn-274a1913-3197-4f59-9554-c569f04b8e08 \
    --name HQ-Network-To-Azure-VNet-1  \
    --vnet-gateway1 VNG-HQ-Network \
    --shared-key $SHAREDKEY \
    --local-gateway2 LNG-Azure-VNet-1

