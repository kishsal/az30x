### Create the Azure-side VPN gateway ###

# Public IP address
az network public-ip create \
    --resource-group learn-274a1913-3197-4f59-9554-c569f04b8e08 \
    --name PIP-VNG-Azure-VNet-1 \
    --allocation-method Dynamic

# Create virtual network gateway
az network vnet-gateway create \
    --resource-group learn-274a1913-3197-4f59-9554-c569f04b8e08 \
    --name VNG-Azure-VNet-1 \
    --public-ip-address PIP-VNG-Azure-VNet-1 \
    --vnet Azure-VNet-1 \
    --gateway-type Vpn \
    --vpn-type RouteBased \
    --sku VpnGw1 \
    --no-wait

#Monitor the progress of the gateway creation
watch -d -n 5 az network vnet-gateway list \
    --resource-group learn-274a1913-3197-4f59-9554-c569f04b8e08 \
    --output table