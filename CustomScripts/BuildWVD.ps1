Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
# Partition & Format the data disk
Get-Disk | Where-Object PartitionStyle -eq 'raw' | Initialize-Disk -PartitionStyle MBR -PassThru | New-Partition -AssignDriveLetter -UseMaximumSize | Format-Volume -FileSystem NTFS -NewFileSystemLabel "DataDisk1" -Confirm:$false
# Install Docker Desktop
# choco install docker-desktop -y
# Install PowerShell-Core 7
choco install powershell-core -y
# Instal Azure Data Studio
choco install azure-data-studio -y
# Scan for updates and install them, including other microsoft products
$Updates = Start-WUScan -SearchCriteria "IsInstalled=0 AND IsHidden=0 AND IsAssigned=1"
Write-Host "Updates found: " $Updates.Count
Install-WUUpdates -Updates $Updates
# Restart Computer
Restart-Computer -Force