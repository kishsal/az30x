### Create VMs in each vNet

#Ubuntu VM in the Apps subnet on Sales vNet
az vm create \
    --resource-group learn-19006fe4-3282-4675-9b6e-51a7a9da30f3 \
    --no-wait \ # lets you continue to work
    --name SalesVM \
    --location northeurope \
    --vnet-name SalesVNet \
    --subnet Apps \
    --image UbuntuLTS \
    --admin-username azureuser \
    --admin-password <password>

#Ubuntu VM in the Apps subnet of Marketing vNet
az vm create \
    --resource-group learn-19006fe4-3282-4675-9b6e-51a7a9da30f3 \
    --no-wait \
    --name MarketingVM \
    --location northeurope \
    --vnet-name MarketingVNet \
    --subnet Apps \
    --image UbuntuLTS \
    --admin-username azureuser \
    --admin-password <password>

#Ubuntu VM in Data subnet on Research vNet
az vm create \
    --resource-group learn-19006fe4-3282-4675-9b6e-51a7a9da30f3 \
    --no-wait \
    --name ResearchVM \
    --location westeurope \
    --vnet-name ResearchVNet \
    --subnet Data \
    --image UbuntuLTS \
    --admin-username azureuser \
    --admin-password <password>

#Watch VMs.  This will refresh every 5 seconds
watch -d -n 5 "az vm list \
    --resource-group learn-19006fe4-3282-4675-9b6e-51a7a9da30f3 \
    --show-details \
    --query '[*].{Name:name, ProvisioningState:provisioningState, PowerState:powerState}' \
    --output table"