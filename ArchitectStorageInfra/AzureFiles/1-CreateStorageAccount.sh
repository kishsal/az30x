### Create a GRS storage account

#create storage account
export STORAGEACCT=learnazurefileshare$RANDOM

az storage account create \
    --name $STORAGEACCT \
    --resource-group learn-bc9e112a-0394-40db-83a5-45aa28a7a5e9 \
    --sku Standard_GRS

#Store key in variable
STORAGEKEY=$(az storage account keys list \
    --resource-group learn-bc9e112a-0394-40db-83a5-45aa28a7a5e9 \
    --account-name $STORAGEACCT \
    --query "[0].value" | tr -d '"')

#Create File share called reports
az storage share create \
    --account-name $STORAGEACCT \
    --account-key $STORAGEKEY \
    --name "reports"

#Create File share called data
az storage share create \
    --account-name $STORAGEACCT \
    --account-key $STORAGEKEY \
    --name "data"