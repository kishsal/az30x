###  Choose a compute provisioning solution for your application ###

#Clone repo
git clone https://github.com/MicrosoftDocs/mslearn-choose-compute-provisioning.git

#### File included
#  Configuration Webserver
# {
#     param ($MachineName)

#     Node $MachineName
#     {
#         #Install the IIS Role
#         WindowsFeature IIS
#         {
#             Ensure = "Present"
#             Name = "Web-Server"
#         }

#         #Install ASP.NET 4.5
#         WindowsFeature ASP
#         {
#             Ensure = "Present"
#             Name = "Web-Asp-Net45"
#         }

#         WindowsFeature WebServerManagementConsole
#         {
#             Name = "Web-Mgmt-Console"
#             Ensure = "Present"
#         }
#     }
# }


#### Update modulesUrl parameter in template.json
# "modulesUrl": {
#     "type": "string",
#     "defaultValue": "https://github.com/MicrosoftDocs/mslearn-choose-compute-provisioning/raw/master/Webserver.zip",
#     "metadata": {
#         "description": "URL for the DSC configuration module."
#     }
# },

#Validate your template
az deployment group validate \
    --resource-group learn-3da45784-5a03-4aa0-804b-9e7572793d96 \
    --template-file template.json \
    --parameters vmName=hostVM1 adminUsername=serveradmin

#Deploy your template
az deployment group create \
    --resource-group learn-3da45784-5a03-4aa0-804b-9e7572793d96 \
    --template-file template.json \
    --parameters vmName=hostVM1 adminUsername=serveradmin

#To list all of the resources in the RG
az resource list \
    --resource-group learn-3da45784-5a03-4aa0-804b-9e7572793d96 \
    --output table \
    --query "[*].{Name:name, Type:type}"

#Run command to generate URL for webserver
echo http://$(az vm show \
    --show-details \
    --resource-group learn-3da45784-5a03-4aa0-804b-9e7572793d96 \
    --name hostVM1 \
    --query publicIps \
    --output tsv)
