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

    01-01-2018 - Created


SYNOPSIS

   This script will apply TLS/SSL lockdowns.


EXAMPLE



==============================================================#>
configuration SP2013TLSLOCKDOWNS
{

Param ([string]$Nodename)
#Unblock-File -Path 'C:\Program Files\WindowsPowerShell\Modules\PSSoftware\PSSoftware.psm1'
#Import-Module PSSoftware -Force 
#Import-DscResource -ModuleName PSSoftware

    # One can evaluate expressions to get the node list
    # E.g: $AllNodes.Where("Role -eq Web").NodeName
    node $Nodename
    {
     #net35-tls12-enable
        Registry Enablenet35-tls12-enable32bit
        {
           Ensure = "Present"
           Key = "HKLM:\SOFTWARE\Microsoft\.NETFramework\v2.0.50727"
           ValueName = "SystemDefaultTlsVersions"
           ValueData = "1"
           ValueType = "Dword"
        }
        #net35-tls12-enable
        Registry Enablenet35-tls12-enable64bit
        {
           Ensure = "Present"
           Key = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v2.0.50727"
           ValueName = "SystemDefaultTlsVersions"
           ValueData = "1"
           ValueType = "Dword"
        }
    
        # 
        Registry EnableSchUseStrongCryptoNET4
        {
           Ensure = "Present"
           Key = "HKLM:\SOFTWARE\Microsoft\.NETFramework\v4.0.30319"
           ValueName = "SchUseStrongCrypto"
           ValueData = "1"
           ValueType = "Dword"
        }
        #
        Registry EnableSchUseStrongCryptoWow6432NodeNET4
        {
           Ensure = "Present"
           Key = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v4.0.30319"
           ValueName = "SchUseStrongCrypto"
           ValueData = "1"
           ValueType = "Dword"
        }
        #1.9 - Disable earlier versions of SSL and TLS in Windows Schannel
        #Disable SSL 2.0 support in Windows Schannel 
        Registry DisableSSL20Client1
        {
            Ensure = 'Present'
            Key = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Client"
            ValueName = "DisabledByDefault"
            ValueData = "1"
            ValueType = "Dword"
            
        }
        Registry DisableSSL20Client2
        {
            Ensure = 'Present'
            Key = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Client"
            ValueName = "Enabled"
            ValueData = "0"
            ValueType = "Dword"
        }
         Registry DisableSSL20Server1
        {
            Ensure = 'Present'
            Key = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Server"
            ValueName = "DisabledByDefault"
            ValueData = "1"
            ValueType = "Dword"
        }
        Registry DisableSSL20Server2
        {
            Ensure = 'Present'
            Key = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Server"
            ValueName = "Enabled"
            ValueData = "0"
            ValueType = "Dword"
        }
        #1.9 - Disable earlier versions of SSL and TLS in Windows Schannel
        #Disable SSL 3.0 support in Windows Schannel 
        Registry CreateSSL30
        {
            Ensure = 'Present'
            Key = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0"
            ValueName = ""
        }
        Registry CreateSSL30Client
        {
            Ensure = 'Present'
            Key = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Client"
            ValueName = ""
        }
        Registry CreateSSL30Server
        {
            Ensure = 'Present'
            Key = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Server"
            ValueName = ""
        }
        Registry CreateSSL30Client1
        {
            Ensure = 'Present'
            Key = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Client"
            ValueName = "DisabledByDefault"
            ValueData = "1"
            ValueType = "Dword"
        }
        Registry CreateSSL30Client2
        {
            Ensure = 'Present'
            Key = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Client"
            ValueName = "Enabled"
            ValueData = "0"
            ValueType = "Dword"
        }
        Registry CreateSSL30CServer1
        {
            Ensure = 'Present'
            Key = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Server"
            ValueName = "DisabledByDefault"
            ValueData = "1"
            ValueType = "Dword"
        }
         Registry CreateSSL30CServer2
        {
            Ensure = 'Present'
            Key = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Server"
            ValueName = "Enabled"
            ValueData = "0"
            ValueType = "Dword"
        }
        #Disable TLS 1.0 support in Windows Schannel 
        Registry CreateTLS10
        {
            Ensure = 'Present'
            Key = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0"
            ValueName = ""
        }
        Registry CreateTLS10Client
        {
            Ensure = 'Present'
            Key = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client"
            ValueName = ""
        }
        Registry CreateTLS10Server
        {
            Ensure = 'Present'
            Key = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server"
            ValueName = ""
        }
        Registry CreateTLS10Client1
        {
            Ensure = 'Present'
            Key = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client"
            ValueName = "DisabledByDefault"
            ValueData = "1"
            ValueType = "Dword"
        }
        Registry CreateTLS10Client2
        {
            Ensure = 'Present'
            Key = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client"
            ValueName = "Enabled"
            ValueData = "0"
            ValueType = "Dword"
        }
        Registry CreateTLS10CServer1
        {
            Ensure = 'Present'
            Key = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server"
            ValueName = "DisabledByDefault"
            ValueData = "1"
            ValueType = "Dword"
        }
         Registry CreateTLS10CServer2
        {
            Ensure = 'Present'
            Key = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server"
            ValueName = "Enabled"
            ValueData = "0"
            ValueType = "Dword"
        }
        #Enable TLS 1.1 support in Windows Schannel 
        Registry CreateTLS11
        {
            Ensure = 'Present'
            Key = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1"
            ValueName = ""
        }
        Registry CreateTLS11Client
        {
            Ensure = 'Present'
            Key = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client"
            ValueName = ""
        }
        Registry CreateTLS11Server
        {
            Ensure = 'Present'
            Key = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server"
            ValueName = ""
        }
        Registry CreateTLS11Client1
        {
            Ensure = 'Present'
            Key = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client"
            ValueName = "DisabledByDefault"
            ValueData = "0"
            ValueType = "Dword"
        }
        Registry CreateTLS11Client2
        {
            Ensure = 'Present'
            Key = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client"
            ValueName = "Enabled"
            ValueData = "1"
            ValueType = "Dword"
        }
        Registry CreateTLS11CServer1
        {
            Ensure = 'Present'
            Key = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server"
            ValueName = "DisabledByDefault"
            ValueData = "0"
            ValueType = "Dword"
        }
         Registry CreateTLS11CServer2
        {
            Ensure = 'Present'
            Key = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server"
            ValueName = "Enabled"
            ValueData = "1"
            ValueType = "Dword"
        }
        #Enable TLS 1.2 support in Windows Schannel 
        Registry CreateTLS12
        {
            Ensure = 'Present'
            Key = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2"
            ValueName = ""
        }
        Registry CreateTLS12Client
        {
            Ensure = 'Present'
            Key = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client"
            ValueName = ""
        }
        Registry CreateTLS12Server
        {
            Ensure = 'Present'
            Key = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server"
            ValueName = ""
        }
        Registry CreateTLS12Client1
        {
            Ensure = 'Present'
            Key = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client"
            ValueName = "DisabledByDefault"
            ValueData = "0"
            ValueType = "Dword"
        }
        Registry CreateTLS12Client2
        {
            Ensure = 'Present'
            Key = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client"
            ValueName = "Enabled"
            ValueData = "1"
            ValueType = "Dword"
        }
        Registry CreateTLS12CServer1
        {
            Ensure = 'Present'
            Key = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server"
            ValueName = "DisabledByDefault"
            ValueData = "0"
            ValueType = "Dword"
        }
        Registry CreateTLS12CServer2
        {
            Ensure = 'Present'
            Key = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server"
            ValueName = "Enabled"
            ValueData = "1"
            ValueType = "Dword"
        }
        #To enable TLS 1.0, TLS 1.1, and TLS 1.2 by default in WinHTTP
        Registry EnableTLS101112
        {
            Ensure = 'Present'
            Key = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\WinHttp"
            ValueName = "DefaultSecureProtocols"
            ValueData = "0x00000A80"
            ValueType = "Dword"
            Hex = $true
        }
        #STIG V-59965 SharePoint must implement required cryptographic protections using cryptographic modules complying with applicable federal laws, Executive Orders, directives, policies, regulations, standards, and guidance.
        Registry EnableCryptographicProtections
        {
            Ensure = 'Present'
            Key = "HKLM:\SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL\00010002"
            ValueName = "Functions"
            ValueData = "TLS_RSA_WITH_AES_128_CBC_SHA,TLS_RSA_WITH_AES_256_CBC_SHA,TLS_RSA_WITH_3DES_EDE_CBC_SHA,TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA_P256,TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA_P384,TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA_P521,TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA_P256,TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA_P384,TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA_P521,TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA_P256,TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA_P384,TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA_P521,TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P256,TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384,TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P521,TLS_DHE_DSS_WITH_AES_128_CBC_SHA,TLS_DHE_DSS_WITH_AES_256_CBC_SHA,TLS_DHE_DSS_WITH_3DES_EDE_CBC_SHA,SSL_CK_DES_192_EDE3_CBC_WITH_MD5,TLS_RSA_WITH_NULL_MD5"
            ValueType = "String"
            
        }
        #1.4 - Install SQL Server 2008 R2 Native Client update for TLS 1.2 support
        Package InstallMicrosoftSQLServer2008R2NativeClient
        {
            Ensure = 'Present'
            Name = 'Microsoft SQL Server 2008 R2 Native Client'
            Path = 'C:\Software\sqlncli.msi'
            ProductId = '21055D1B-A825-492A-8FD6-C630C5AE3CB3'
            Arguments = 'IACCEPTSQLNCLILICENSETERMS=YES'
            LogPath = 'c:\sqlncli-msi-InstallLog.txt'
        }


    }
}
SP2013TLSLOCKDOWNS -Nodename $env:COMPUTERNAME -OutputPath c:\dsc 
Start-DscConfiguration -Path C:\dsc\ -Wait -Force -Verbose

