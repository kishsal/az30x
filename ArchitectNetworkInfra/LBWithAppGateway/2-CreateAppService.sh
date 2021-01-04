### Create App

APPSERVICE="licenserenewal$RANDOM"

#Create app service plan
az appservice plan create \
    --resource-group $RG \
    --name vehicleAppServicePlan \
    --sku S1

#Create webapp and deploy site
az webapp create \
    --resource-group $RG \
    --name $APPSERVICE \
    --plan vehicleAppServicePlan \
    --deployment-source-url https://github.com/MicrosoftDocs/mslearn-load-balance-web-traffic-with-application-gateway \
    --deployment-source-branch appService --runtime "DOTNETCORE|2.1"

    