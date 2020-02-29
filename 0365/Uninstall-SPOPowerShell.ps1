<#
 # Validate Current Version Installed
#>
Get-Module -Name Microsoft.Online.SharePoint.PowerShell -ListAvailable | Select Name,Version 

<#
# If Installed, Manually uninstall SharePoint Online Management Shell MSI and SharePoint Online SDK from Apps and Features
#>

<#
# Uninstall Microsoft.sharePoint.xxx from directory C:\Windows\Microsoft.NET\assembly\GAC_MSIL
#>
Write-Host "Cleaning Up GAC_MSIL..."
gci -Path "C:\Windows\Microsoft.NET\assembly\GAC_MSIL" | ? {$_.Name -like "*Microsoft.SharePoint*"} | Remove-Item -Force -Verbose


<#
 # Close current powershell window, open a new powershell window as Admin an Uninstall
#>
Uninstall-Module Microsoft.Online.SharePoint.PowerShell -Force -AllVersions
#confirm Microsoft.Online.SharePoint.PowerShell has been uninstalled
gci -Path "C:\Program Files\WindowsPowerShell\Modules" | ? {$_.Name -like "Microsoft.Online.SharePoint.PowerShell"} 
#confirm no no version is installed
Get-Module -Name Microsoft.Online.SharePoint.PowerShell -ListAvailable | Select Name,Version 


<#
 # Install
#>
Install-Module -Name Microsoft.Online.SharePoint.PowerShell -Verbose -Force
<#
# Can Optionally Manually install
#>
Save-Module -Name Microsoft.Online.SharePoint.PowerShell -Path "C:\Program Files\WindowsPowerShell\Modules" -Verbose

#confirm no no version is installed
Get-Module -Name Microsoft.Online.SharePoint.PowerShell -ListAvailable | Select Name,Version 

<#
# Import Module Microsoft.Online.SharePoint.PowerShell
#>
Import-Module Microsoft.Online.SharePoint.PowerShell -Verbose 

<#
 # check modern auth force via reg
#>
Get-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\SPO\CMDLETS

<#
 # set modern auth force via reg, if legacyauth disabled on tenant, ADFS, Conditinal Access
#>
Set-Item -Path HKCU:\SOFTWARE\Microsoft\SPO\CMDLETS
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\SPO\CMDLETS -Name ForceOAuth -Value 1
Get-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\SPO\CMDLETS



<#
 # Connect to tenant using modern auth
#>
Connect-SPOService -Url https://contoso-admin.sharepoint.us
Get-SPOSite


<#
 # Connect to tenant using user credentials while forcing Modern Auth = ForceOAuth = 1
#>
$admin = "admin@contoso.onmicrosoft.com"
$org = "contoso"
$userCred = Get-Credential -UserName $admin -Message "Type in SPO Admin password"
Connect-SPOService -Url https://$org-admin.sharepoint.us -Credential $userCred -Verbose
Get-SPOSite



<#
 #  Check/Ensure SPO Tenant LegacyAuthProtocolsEnabled settings are disabled 
 changes occur within 24hrs
#>
(Get-SPOTenant).LegacyAuthProtocolsEnabled 
Set-SPOTenant -LegacyAuthProtocolsEnabled:$false
(Get-SPOTenant).LegacyAuthProtocolsEnabled 
