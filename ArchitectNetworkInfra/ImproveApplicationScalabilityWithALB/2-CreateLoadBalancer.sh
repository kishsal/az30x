### Create a load balancer ###

#Create new PIP
az network public-ip create \
  --resource-group learn-c46f0c7d-f5e4-475f-b551-b47914e98e58 \
  --allocation-method Static \
  --name myPublicIP

#Create Load Balancer
az network lb create \
  --resource-group learn-c46f0c7d-f5e4-475f-b551-b47914e98e58 \
  --name myLoadBalancer \
  --public-ip-address myPublicIP \
  --frontend-ip-name myFrontEndPool \
  --backend-pool-name myBackEndPool

#Create health probe
az network lb probe create \
  --resource-group learn-c46f0c7d-f5e4-475f-b551-b47914e98e58 \
  --lb-name myLoadBalancer \
  --name myHealthProbe \
  --protocol tcp \
  --port 80

#Create load balancer rule
az network lb rule create \
  --resource-group learn-c46f0c7d-f5e4-475f-b551-b47914e98e58 \
  --lb-name myLoadBalancer \
  --name myHTTPRule \
  --protocol tcp \
  --frontend-port 80 \
  --backend-port 80 \
  --frontend-ip-name myFrontEndPool \
  --backend-pool-name myBackEndPool \
  --probe-name myHealthProbe

#Connect the virtual machines to the back-end pool by updating the network interfaces
az network nic ip-config update \
  --resource-group learn-c46f0c7d-f5e4-475f-b551-b47914e98e58 \
  --nic-name webNic1 \
  --name ipconfig1 \
  --lb-name myLoadBalancer \
  --lb-address-pools myBackEndPool

az network nic ip-config update \
  --resource-group learn-c46f0c7d-f5e4-475f-b551-b47914e98e58 \
  --nic-name webNic2 \
  --name ipconfig1 \
  --lb-name myLoadBalancer \
  --lb-address-pools myBackEndPool

#Get PIP of the LB
echo http://$(az network public-ip show \
                --resource-group learn-c46f0c7d-f5e4-475f-b551-b47914e98e58 \
                --name myPublicIP \
                --query ipAddress \
                --output tsv)

## Test the loab balancer config
# In a new browser tab, go to the public IP address that you noted. You'll see that the response is returned from one of the virtual machines.

# Try a "force refresh" by pressing Ctrl+F5 a few times to see that the response is returned randomly from both virtual machines.

# On the Azure portal  menu or from the Home page, select All resources. Then select webVM1 > Stop.

# Return to the tab that shows the website and force a refresh of the webpage. All requests are returned from webVM2.