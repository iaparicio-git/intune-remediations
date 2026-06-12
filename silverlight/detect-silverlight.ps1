<#
    detection script for Microsoft Silverlight
    - will be deployed in Intune
    - should be safe to assign to ALL devies as Silverlight reached EOS in 2021
    - MSI based installed so uninstall should work using msiexec /x {[chars]} /qn
#>

# $nonCompliant = $false
$silverlightPaths = @(
    @{
        Name = "Basic"
        RegPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*"
    },
    @{
        Name = "wow6432node"
        RegPath = "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
    }
)

foreach ($p in $silverlightPaths) {
    $path = $p.RegPath
    # capture reg key that has a value of DisplayName = "*silverlight*"
    $regKey = Get-ItemProperty -Path $path |
    Where-Object { $_.displayName -like "*silverlight*" }

    # set exit code based on existence of silverlight regkey
    if ($regKey) {
        Write-Host "Software exists. Remediation required"
        exit 1
    } else {
        Write-Host "Registry key for software not found. Device is compliant"
        exit 0
    }
}
