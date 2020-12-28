### Verification Steps ###

#Confirm that Azure-VNet-1-To-HQ-Network is connected
az network vpn-connection show \
    --resource-group learn-274a1913-3197-4f59-9554-c569f04b8e08 \
    --name Azure-VNet-1-To-HQ-Network  \
    --output table \
    --query '{Name:name,ConnectionStatus:connectionStatus}'


#Confirm that HQ-Network-To-Azure-VNet-1 is connected
az network vpn-connection show \
    --resource-group learn-274a1913-3197-4f59-9554-c569f04b8e08 \
    --name HQ-Network-To-Azure-VNet-1  \
    --output table \
    --query '{Name:name,ConnectionStatus:connectionStatus}'

