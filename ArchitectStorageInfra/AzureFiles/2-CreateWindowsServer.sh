### Create and connect to a Windows server


#Create Windows VM
az vm create \
    --resource-group learn-bc9e112a-0394-40db-83a5-45aa28a7a5e9 \
    --name 2019FileServer \
    --image Win2019Datacenter \
    --admin-username azureuser

#RDP to VM

#Run the following command in powershell
$connectTestResult = Test-NetConnection -ComputerName learnazurefileshare8968.file.core.windows.net -Port 445
if ($connectTestResult.TcpTestSucceeded) {
    # Save the password so the drive will persist on reboot
    cmd.exe /C "cmdkey /add:`"learnazurefileshare8968.file.core.windows.net`" /user:`"Azure\learnazurefileshare8968`" /pass:`"6xDf56FIW9A6XvIMFObMV5oWkUW5Me7hZtEvqZQEy+oy950jvVK2/hWfPAwMf3C6M+Ou7D+LbFPGgclfFHkuTA==`""
    # Mount the drive
    New-PSDrive -Name F -PSProvider FileSystem -Root "\\learnazurefileshare8968.file.core.windows.net\data" -Persist
} else {
    Write-Error -Message "Unable to reach the Azure storage account via port 445. Check to make sure your organization or ISP is not blocking port 445, or use Azure P2S VPN, Azure S2S VPN, or Express Route to tunnel SMB traffic over a different port."
}

