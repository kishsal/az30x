### Create the on-premises VPN gateway ###

#Create Public IP
az network public-ip create \
    --resource-group learn-274a1913-3197-4f59-9554-c569f04b8e08 \
    --name PIP-VNG-HQ-Network \
    --allocation-method Dynamic

# Create virtual network gateway
az network vnet-gateway create \
    --resource-group learn-274a1913-3197-4f59-9554-c569f04b8e08 \
    --name VNG-HQ-Network \
    --public-ip-address PIP-VNG-HQ-Network \
    --vnet HQ-Network \
    --gateway-type Vpn \
    --vpn-type RouteBased \
    --sku VpnGw1 \
    --no-wait

#Monitor the progress of the gateway creation
watch -d -n 5 az network vnet-gateway list \
    --resource-group learn-274a1913-3197-4f59-9554-c569f04b8e08 \
    --output table