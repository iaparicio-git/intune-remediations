<#
    remediation script for Microsoft Silverlight
    - will be deployed in Intune
    - should be safe to assign to ALL devies as Silverlight reached EOS in 2021
    - MSI based installed so uninstall should work using msiexec /x {[chars]} /qn
#>

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

    # capture the existing regkey to be used in the uninstall command
    $regKey = Get-ItemProperty -Path $path |
    Where-Object { $_.displayName -like "*silverlight*" } |
    Select-Object -ExpandProperty PSChildName

    # run msi uninstall command
    Start-Process -FilePath "msiexec.exe" -ArgumentList "/x $regKey /qn" -Wait -NoNewWindow
}
