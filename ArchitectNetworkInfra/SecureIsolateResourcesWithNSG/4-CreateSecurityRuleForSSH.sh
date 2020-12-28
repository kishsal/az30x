### Create a security rule for SSH ###

#Create inbound security rule to enable SSH
az network nsg rule create \
    --resource-group $rg \
    --nsg-name ERP-SERVERS-NSG \
    --name AllowSSHRule \
    --direction Inbound \
    --priority 100 \
    --source-address-prefixes '*' \
    --source-port-ranges '*' \
    --destination-address-prefixes '*' \
    --destination-port-ranges 22 \
    --access Allow \
    --protocol Tcp \
    --description "Allow inbound SSH"

# Check if you can connect to AppServer
ssh azureuser@$APPSERVERIP -o ConnectTimeout=5

#Check if you can connect to DataServer
ssh azureuser@$DATASERVERIP -o ConnectTimeout=5


#Create a rule to prevent web access
# Server name	IP address
# AppServer	10.0.0.4
# DataServer	10.0.1.4
az network nsg rule create \
    --resource-group $rg \
    --nsg-name ERP-SERVERS-NSG \
    --name httpRule \
    --direction Inbound \
    --priority 150 \
    --source-address-prefixes 10.0.1.4 \
    --source-port-ranges '*' \
    --destination-address-prefixes 10.0.0.4 \
    --destination-port-ranges 80 \
    --access Deny \
    --protocol Tcp \
    --description "Deny from DataServer to AppServer on port 80"

#Test HTTP Connectivity between VMs
#Check if AppServer can communicate with DataServer
ssh -t azureuser@$APPSERVERIP 'wget http://10.0.1.4; exit; bash'

#Check if DataServer can communication with AppServer
ssh -t azureuser@$DATASERVERIP 'wget http://10.0.0.4; exit; bash'


