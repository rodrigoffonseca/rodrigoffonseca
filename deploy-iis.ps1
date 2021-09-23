#deploy-iis
add-WindowsFeature -Name "Web-Server" -IncludeAllSubFeature -IncludeManagementTools
New-NetFirewallRule –DisplayName "Allow ICMPv4-In" –Protocol ICMPv4
$sitePathzip = "C:\Inetpub\wwwroot\aznetworkinghandson\zip"
$output = "$sitePath\app.zip"
$sitePath = "C:\Inetpub\wwwroot\aznetworkinghandson"
$url = "https://aznetworkinghandson.blob.core.windows.net/public/app.zip"
New-Item -ItemType Directory $sitePathzip -Force
(New-Object System.Net.WebClient).DownloadFile($url, $output)
Expand-Archive -Path $output -DestinationPath $sitePath -Force
Remove-Website -Name 'Default Web Site'
New-Website -Name 'Default Web Site' -Port 80 -PhysicalPath "$sitePath\app"
