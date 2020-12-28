### Deploy an app security group ###

#Create app security group called ERP-DB-SERVERS-ASG
az network asg create \
    --resource-group $rg \
    --name ERP-DB-SERVERS-ASG

#Associate DataServer with group
az network nic ip-config update \
    --resource-group $rg \
    --application-security-groups ERP-DB-SERVERS-ASG \
    --name ipconfigDataServer \
    --nic-name DataServerVMNic \
    --vnet-name ERP-servers \
    --subnet Databases

#Update the HTTP rule in the ERP-SERVERS-NSG network security group
az network nsg rule update \
    --resource-group $rg \
    --nsg-name ERP-SERVERS-NSG \
    --name httpRule \
    --direction Inbound \
    --priority 150 \
    --source-address-prefixes "" \
    --source-port-ranges '*' \
    --source-asgs ERP-DB-SERVERS-ASG \
    --destination-address-prefixes 10.0.0.4 \
    --destination-port-ranges 80 \
    --access Deny \
    --protocol Tcp \
    --description "Deny from DataServer to AppServer on port 80 using application security group"

#Test the updated rule
#Check if AppServer can communicate with DataServer over HTTP
ssh -t azureuser@$APPSERVERIP 'wget http://10.0.1.4; exit; bash'

#Check if DataServer can communicate with AppServer over HTTP
ssh -t azureuser@$DATASERVERIP 'wget http://10.0.0.4; exit; bash'