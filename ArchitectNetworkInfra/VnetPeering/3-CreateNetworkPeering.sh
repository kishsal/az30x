### Create network peering

#Peer SalesvNet and MarketingVNet
az network vnet peering create \
    --name SalesVNetToMarketingVNet \
    --remote-vnet MarketingVNet \
    --resource-group learn-19006fe4-3282-4675-9b6e-51a7a9da30f3 \
    --vnet-name SalesVNet \
    --allow-vnet-access

#Peer MarketingVNet and SalesvNet
az network vnet peering create \
    --name MarketingVNet-To-SalesVNet \
    --remote-vnet SalesVNet \
    --resource-group learn-19006fe4-3282-4675-9b6e-51a7a9da30f3 \
    --vnet-name MarketingVNet \
    --allow-vnet-access

#Peer MarketingVnet and ResearchVnet
az network vnet peering create \
    --name MarketingVNet-To-ResearchVNet \
    --remote-vnet ResearchVNet \
    --resource-group learn-19006fe4-3282-4675-9b6e-51a7a9da30f3 \
    --vnet-name MarketingVNet \
    --allow-vnet-access

#Peer ResearchVnet and MarketingVnet
az network vnet peering create \
    --name ResearchVNet-To-MarketingVNet \
    --remote-vnet MarketingVNet \
    --resource-group learn-19006fe4-3282-4675-9b6e-51a7a9da30f3 \
    --vnet-name ResearchVNet \
    --allow-vnet-access

#Check peering connections
az network vnet peering list \
    --resource-group learn-19006fe4-3282-4675-9b6e-51a7a9da30f3 \
    --vnet-name SalesVNet \
    --output table

az network vnet peering list \
    --resource-group learn-19006fe4-3282-4675-9b6e-51a7a9da30f3 \
    --vnet-name ResearchVNet \
    --output table

az network vnet peering list \
    --resource-group learn-19006fe4-3282-4675-9b6e-51a7a9da30f3 \
    --vnet-name MarketingVNet \
    --output table

# Check effective Routes
az network nic show-effective-route-table \
    --resource-group learn-19006fe4-3282-4675-9b6e-51a7a9da30f3 \
    --name SalesVMVMNic \
    --output table

az network nic show-effective-route-table \
    --resource-group learn-19006fe4-3282-4675-9b6e-51a7a9da30f3 \
    --name MarketingVMVMNic \
    --output table

az network nic show-effective-route-table \
    --resource-group learn-19006fe4-3282-4675-9b6e-51a7a9da30f3 \
    --name ResearchVMVMNic \
    --output table