<# 
    note: will return "Write-Error: Requested registry access is not allowed.", if not ran under
    elevated/admin context. Shouldn't encounter this once deployed in Intune since it will run under
    SYSTEM context which has full access to HKLM
#>
$regKeyPath = "HKLM:\SOFTWARE\Policies\Adobe\Acrobat Reader\DC\FeatureLockDown"
$valueName = "bEnableFlash"
$valueType = "DWORD"
$valueData = 0

try {
    # ensure key exists
    if(!(Test-Path $regKeyPath)) {
        New-Item -Path $regKeyPath -Force | Out-Null
    }

    # create or update the value
    if(Get-ItemProperty -Path $regKeyPath -Name $valueName -ErrorAction SilentlyContinue) {
        Set-ItemProperty -Path $regKeyPath -Name $valueName -Value $valueData -ErrorAction Stop
    }
    else {
        New-ItemProperty -Path $regKeyPath -Name $valueName -Value $valueData -PropertyType $valueType -Force | Out-Null
    }
    Write-Output "Set data of $valueName to $valueData"
}
catch {
    Write-Error $_
    exit 1
}
