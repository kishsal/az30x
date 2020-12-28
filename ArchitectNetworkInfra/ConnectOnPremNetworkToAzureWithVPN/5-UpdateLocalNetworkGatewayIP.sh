### Update the local network gateway IP references ###

# Check virtual network gateways
az network vnet-gateway list \
    --resource-group learn-274a1913-3197-4f59-9554-c569f04b8e08 \
    --query "[?provisioningState=='Succeeded']" \
    --output table

# Retrieve IPv4 address PIP-VNG-Azure-VNet-1
PIPVNGAZUREVNET1=$(az network public-ip show \
    --resource-group learn-274a1913-3197-4f59-9554-c569f04b8e08 \
    --name PIP-VNG-Azure-VNet-1 \
    --query "[ipAddress]" \
    --output tsv)

# Update local network gateway to point to PIP
az network local-gateway update \
    --resource-group learn-274a1913-3197-4f59-9554-c569f04b8e08 \
    --name LNG-Azure-VNet-1 \
    --gateway-ip-address $PIPVNGAZUREVNET1

# Retrieve IPv4 address PIP-VNG-HQ-Network
PIPVNGHQNETWORK=$(az network public-ip show \
    --resource-group learn-274a1913-3197-4f59-9554-c569f04b8e08 \
    --name PIP-VNG-HQ-Network \
    --query "[ipAddress]" \
    --output tsv)

# Update local network gateway to point to PIP
az network local-gateway update \
    --resource-group learn-274a1913-3197-4f59-9554-c569f04b8e08 \
    --name LNG-HQ-Network \
    --gateway-ip-address $PIPVNGHQNETWORK