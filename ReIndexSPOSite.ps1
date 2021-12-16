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

HISTORY

    12-16-2021 - Created


SYNOPSIS

   Reindex SPO Site using PNP PowerShell


EXAMPLE



==============================================================#>

#Install PNP PowerShell
Install-Module SharePointPnPPowerShellOnline

#Config Variables
$SiteURL = "https://contoso-my.sharepoint.us/personal/jon_doe_contoso_onmicrosoft_com"
 
#Connect to PnP Online
Connect-PnPOnline -Url $SiteURL 
 
#Get the Web
$SPOWeb = Get-PnPWeb
 
#Request Reindex
Request-PnPReIndexWeb -Web $SPOWeb

#Can optionally check status of index content
#https://docs.microsoft.com/en-us/powershell/module/sharepoint-pnp/get-pnpsearchcrawllog?view=sharepoint-ps#example-2
#Make sure you are granted access to the crawl log via the SharePoint search admin center at https://-admin.sharepoint.com/_layouts/15/searchadmin/crawllogreadpermission.aspx in order to run this cmdlet.
Get-PnPSearchCrawlLog -Filter "https://contoso-my.sharepoint.us/personal/jon_doe_contoso_onmicrosoft_com" 

