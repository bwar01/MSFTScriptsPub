<#

 Microsoft provides programming examples for illustration only, without warranty either expressed or
 implied, including, but not limited to, the implied warranties of merchantability and/or fitness 
 for a particular purpose. 
 
 This sample assumes that you are familiar with the programming language being demonstrated and the 
 tools used to create and debug procedures. Microsoft support professionals can help explain the 
 functionality of a particular procedure, but they will not modify these examples to provide added 
 functionality or construct procedures to meet your specific needs. if you have limited programming 
 experience, you may want to contact a Microsoft Certified Partner or the Microsoft fee-based consulting 
 line at (800) 936-5200. 

#==============================================================


#>

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
 # Connect to tenant GCCH tenatn using modern auth
#>
Connect-SPOService -Url https://contoso-admin.sharepoint.us -Region ITAR
Get-SPOSite




<#
 # Connect to tenant using user credentials while forcing Modern Auth = ForceOAuth = 1 Will not work if MFA is enabled.  
 # Error: Could not authenticate to SharePoint Online https://tenant-admin.sharepoint.us/ using OAuth 2.0 
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
