### Implement a hub-spoke network topology on Azure ###

#Create vNet and subnets
az deployment group create \
    --resource-group learn-8e5f9cc1-d1d8-4364-807e-e61d4fcdb81f \
    --template-uri https://raw.githubusercontent.com/MicrosoftDocs/mslearn-hub-and-spoke-network-architecture/master/azuredeploy.json

#Following steps are created in the portal

https://docs.microsoft.com/en-us/learn/modules/hub-and-spoke-network-architecture/4-exercise-implement-hub-spoke

