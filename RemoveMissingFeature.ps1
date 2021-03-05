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

    


SYNOPSIS

   Based on: https://docs.microsoft.com/en-us/archive/blogs/dawiese/post-upgrade-cleanup-missing-server-side-dependencies


EXAMPLE



==============================================================#>

#Test Content database
$wa = Get-SPWebApplication "https://sharepoint.contoso.com"
$outputPath = "\\tools\files\Output\Test_Wss_Content_MissingAssembly_{0}.txt" -f (Get-Date -Format hhmmss)
$dbName = "WSS_Content_MissingAssembly"
$slqServer = "SPSQL"
Test-SPContentDatabase -Name $dbName -WebApplication $wa -ServerInstance $slqServer -ShowLocation:$true -ExtendedCheck:$false | Out-File $outputPath Write-Host "Test results written to $outputPath"




#Remove Missing Feature

$featureID = "<MISSING FEATURE FROM REPORT ABOVE>"
$siteID = "<SITE ID FROM LOCATION FOUND IN REPORT ABOVE>"
#Display site information
$site = Get-SPSite $siteID
Write-Host "Checking Site:" $site.Url
#Remove the feature from all subsites
ForEach ($web in $Site.AllWebs)
    {
        If($web.Features[$featureID])
            {
                Write-Host "`nFound Feature $featureID in web:"$Web.Url"`nRemoving feature"
                $web.Features.Remove($featureID, $true)
            }
            else
            {
                Write-Host "`nDid not find feature $featureID in web:" $Web.Url
            }  
    }
#Remove the feature from the site collection
If ($Site.Features[$featureID])
    {
        Write-Host "`nFound feature $featureID in site:"$site.Url"`nRemoving Feature"
        $site.Features.Remove($featureID, $true)
    }
    else
    {
        Write-Host "Did not find feature $featureID in site:" $site.Url
    }