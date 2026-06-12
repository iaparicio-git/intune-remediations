<#
    Registry mapping:
    - Hive          = HKLM (HKEY_LOCAL_MACHINE)
    - Key path      = SOFTWARE\Policies\Adobe\Acrobat Reader\DC\FeatureLockDown
    - Value name    = bEnableFlash
    - Value type    = REG_DWORD (not defined or used)
    - Value data    = 0x0 (0)

    Get-ItemProperty returns a PowerShell object representing the registry key.
    Each registry value under the key is exposed as a property on that object.
    bEnableFlash is one such property whose value is compared for compliance.
#>

$regKeyPath = "HKLM:\SOFTWARE\Policies\Adobe\Acrobat Reader\DC\FeatureLockDown"
$valueName = "bEnableFlash"
$expectedData = 0

# check if the key exists
if (!(Test-Path $regKeyPath)) {
    # Write-Host "Registry key does not exist"
    exit 1
}

# capture the data of the value we're looking for in a PSCustomObject that represents the regKey
try {
    $regItem = Get-ItemProperty -Path $regKeyPath # -ErrorAction Stop
}
catch {
    exit 1
} 

if (!($regItem.PSObject.Properties.Name -contains $valueName)) {
    # Write-Warning "Registry value does not exist"
    exit 1
}

$actualData = $regItem.$valueName

# compare the captured value with the expected value
if($actualData -eq $expectedData) {
    # Write-Output "Value is correctly set to 0"
    exit 0
}
else {
    # Write-Warning "Value is not 0"
    exit 1
}
