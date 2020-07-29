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
#
# Using Graph API using cert auth flow
1. Enforce TLS 1.2 connection
2. Import MSAL.PS - pulls Auth token
3. Import JWTDetails - token inspection
4. Set clientID, tenantID, ClientCertification registered with Azure App
5. Get Auth tokent, force refresh every request
6. Enumerate SPO List Items using Graph API
7. Output results to file system
#> 

# Set TLS 1.2 
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls -bor [Net.SecurityProtocolType]::Tls11 -bor [Net.SecurityProtocolType]::Tls12


#Import MSAL and JWTDetails Module
Import-Module MSAL.PS
Import-Module JWTDetails


# Set ClientID, TenantID, ClientCertificate
$clientID = '<CLIENT ID>'
$tenantID = '<TEANTN ID>'
$ClientCertificate = Get-Item "Cert:\LocalMachine\My\<CertThumbprint>" 
$TenantName = "<tenant>.sharepoint.us"
$ReportLocation = "c:\temp\SPOListData.csv"


# Set config data
$config = @{
  clientID       = $clientID
  tenantID       = $tenantID
  ClientCertificate      = $ClientCertificate
  Scopes         = "https://graph.microsoft.us/.default " 
  redirectUri = "https://login.microsoftonline.us/common/oauth2/nativeclient"
  reportLocation = $ReportLocation
} 


#Clear previous tokens
Clear-MsalTokenCache


# Get MSAL Token, force refresh
$myAccessToken = Get-MsalToken -ClientId $config.clientID -TenantId $config.tenantID -ClientCertificate $config.ClientCertificate -AzureCloudInstance AzureUsGovernment -Scopes $config.Scopes -ForceRefresh

#Inspect Token
#$myAccessToken.AccessToken | Get-JWTDetails

#Using Graph API (https://docs.microsoft.com/en-us/graph/api/listitem-list?view=graph-rest-1.0&tabs=http)
#Enumerate items in a list 
$result = (Invoke-RestMethod -Headers @{Authorization = "Bearer $($myAccessToken.AccessToken)" } `
  -Uri "https://graph.microsoft.us/v1.0/sites/$TenantName/lists/6D93FCDC-DB19-44CA-8A28-B89624EAAC68/items?top=100000&expand=fields" `
  -Method Get).value

#Output results to file system
$result.fields | select * | Export-Csv $config.ReportLocation -NoTypeInformation -Force

