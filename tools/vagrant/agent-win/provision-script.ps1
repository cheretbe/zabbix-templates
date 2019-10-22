Set-StrictMode -Version Latest
$ErrorActionPreference = [System.Management.Automation.ActionPreference]::Stop

$agentMSIURL = "https://www.zabbix.com/downloads/4.0.13/zabbix_agent-4.0.13-win-amd64-openssl.msi"

Write-Output "Checking if Zabbix agent package is installed"

$existingMSIObjects = Get-WmiObject Win32_Product |
  Where-Object { $_.IdentifyingNumber -eq "{9D68823B-02AD-4EEF-8DFF-BE903D09AF6C}" } |
  Measure-Object

if ($existingMSIObjects.Count -eq 0) {
  $tempFileName = [system.io.path]::Combine(${Env:TEMP}, "zabbix_agent.msi")
  Write-Output ("Downloading {0}" -f $agentMSIURL)
  (New-Object System.Net.WebClient).DownloadFile($agentMSIURL, $tempFileName)

  Write-Output "Installing MSI package"
  $processObj = Start-Process msiexec.exe -Wait -PassThru `
    -ArgumentList ("/i {0} /passive /norestart SERVER=192.168.200.10 SERVERACTIVE=192.168.200.10" -f $tempFileName)

  Remove-Item -Path $tempFileName -Force -ErrorAction SilentlyContinue

  if ($processObj.ExitCode -ne 0)
    { Throw ("msiexec.exe call failed: exit code {0}" -f $processObj.ExitCode) }
} else {
  Write-Output "Zabbix agent package is already installed"
} #if