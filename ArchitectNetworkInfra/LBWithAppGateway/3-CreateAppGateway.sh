### Create and configure an Application Gateway ###

#Create network for App Gateway
az network vnet subnet create \
  --resource-group $RG \
  --vnet-name vehicleAppVnet  \
  --name appGatewaySubnet \
  --address-prefixes 10.0.0.0/24

#Create PIP and DNS for App Gateway
az network public-ip create \
  --resource-group $RG \
  --name appGatewayPublicIp \
  --sku Standard \
  --dns-name vehicleapp${RANDOM}

#Create an app gateway
az network application-gateway create \
--resource-group $RG \
--name vehicleAppGateway \
--sku WAF_v2 \
--capacity 2 \
--vnet-name vehicleAppVnet \
--subnet appGatewaySubnet \
--public-ip-address appGatewayPublicIp \
--http-settings-protocol Http \
--http-settings-port 8080 \
--private-ip-address 10.0.0.4 \
--frontend-port 8080

#Find PIP for Webservers
az vm list-ip-addresses \
  --resource-group $RG \
  --name webServer1 \
  --query [0].virtualMachine.network.privateIpAddresses[0] \
  --output tsv

az vm list-ip-addresses \
  --resource-group $RG \
  --name webserver2 \
  --query [0].virtualMachine.network.privateIpAddresses[0] \
  --output tsv

#Add back-end pools
az network application-gateway address-pool create \
  --gateway-name vehicleAppGateway \
  --resource-group $RG \
  --name vmPool \
  --servers 10.0.1.4 10.0.1.5

az network application-gateway address-pool create \
    --resource-group $RG \
    --gateway-name vehicleAppGateway \
    --name appServicePool \
    --servers $APPSERVICE.azurewebsites.net

#Create front-end port
az network application-gateway frontend-port create \
    --resource-group $RG \
    --gateway-name vehicleAppGateway \
    --name port80 \
    --port 80

#Create listener port
az network application-gateway http-listener create \
    --resource-group $RG \
    --name vehicleListener \
    --frontend-port port80 \
    --frontend-ip appGatewayFrontendIP \
    --gateway-name vehicleAppGateway

#Add a health probe
az network application-gateway probe create \
    --resource-group $RG \
    --gateway-name vehicleAppGateway \
    --name customProbe \
    --path / \
    --interval 15 \
    --threshold 3 \
    --timeout 10 \
    --protocol Http \
    --host-name-from-http-settings true

#With health probe, create HTTP settings
az network application-gateway http-settings create \
    --resource-group $RG \
    --gateway-name vehicleAppGateway \
    --name appGatewayBackendHttpSettings \
    --host-name-from-backend-pool true \
    --port 80 \
    --probe customProbe

###Configure Path-based routing
#create path map for VMpool
az network application-gateway url-path-map create \
    --resource-group $RG \
    --gateway-name vehicleAppGateway \
    --name urlPathMap \
    --paths /VehicleRegistration/* \
    --http-settings appGatewayBackendHttpSettings \
    --address-pool vmPool

#Create map rul for appServicePool
az network application-gateway url-path-map rule create \
    --resource-group $RG \
    --gateway-name vehicleAppGateway \
    --name appServiceUrlPathMap \
    --paths /LicenseRenewal/* \
    --http-settings appGatewayBackendHttpSettings \
    --address-pool appServicePool \
    --path-map-name urlPathMap

#Create routing rul for path map
az network application-gateway rule create \
    --resource-group $RG \
    --gateway-name vehicleAppGateway \
    --name appServiceRule \
    --http-listener vehicleListener \
    --rule-type PathBasedRouting \
    --address-pool appServicePool \
    --url-path-map urlPathMap

#delete the rule that was created when we initially deployed the Application Gateway
az network application-gateway rule delete \
    --resource-group $RG \
    --gateway-name vehicleAppGateway \
    --name rule1