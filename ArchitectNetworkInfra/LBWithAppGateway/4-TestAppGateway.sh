### Test your Application Gateway

# Generate the root URL for App gateway
echo http://$(az network public-ip show \
  --resource-group $RG \
  --name appGatewayPublicIp \
  --query dnsSettings.fqdn \
  --output tsv)

# Register a Vehicle, enter the details of a vehicle, and then click Register.
# Click Refresh in the address bar of the web browser. Notice that your session should now be connected to a different web server.
# Click Refresh a few more times. The requests should oscillate between servers

## Test the resilience of Application Gateway to a failed server

#stop and deallocate VM
az vm deallocate \
  --resource-group $RG \
  --name webServer1

#Return to the application in the web browser and click Refresh several times. Notice that the web browser now only connects to webServer2.

#Start VM
az vm start \
  --resource-group $RG \
  --name webServer1