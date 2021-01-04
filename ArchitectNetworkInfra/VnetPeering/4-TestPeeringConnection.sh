### Test peering connections

#List IP addresses of VMs
az vm list \
    --resource-group learn-19006fe4-3282-4675-9b6e-51a7a9da30f3 \
    --query "[*].{Name:name, PrivateIP:privateIps, PublicIP:publicIps}" \
    --show-details \
    --output table

#Test connections from SalesVM
ssh -o StrictHostKeyChecking=no azureuser@<SalesVM public IP>

ssh -o StrictHostKeyChecking=no azureuser@<MarketingVM private IP>

ssh -o StrictHostKeyChecking=no azureuser@<ResearchVM private IP>


#Test connections from ResearchVM
ssh -o StrictHostKeyChecking=no azureuser@<ResearchVM public IP>

ssh -o StrictHostKeyChecking=no azureuser@<MarketingVM private IP>

ssh -o StrictHostKeyChecking=no azureuser@<SalesVM private IP>
