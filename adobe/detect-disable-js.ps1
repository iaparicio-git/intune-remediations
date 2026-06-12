# Adobe Reader/Acrobat Disable JS - Detection Script
# exit 0 = compliant
# exit 1 = non-compliant
# may still run on devies that don't have either adobe version installed but the
# policy keys still exists after uninstalling it. This is harmless as the keys will
# be ignored if the software isn't present.

$readerPath = "HKLM:\SOFTWARE\Policies\Adobe\Acrobat Reader\DC\FeatureLockDown"
$acrobatPath = "HKLM:\SOFTWARE\Policies\Adobe\Adobe Acrobat\DC\FeatureLockDown"
$valueName = "bDisableJavaScript"
$expectedData = 1
$nonCompliant = $false

$adobeProducts = @(
    @{
        Name = "Adobe Acrobat Reader DC"
        RegPath = $readerPath
    },
    @{
        Name = "Adobe Acrobat DC"
        RegPath = $acrobatPath
    }
)

foreach ($product in $adobeProducts) {
    $basePath = Split-Path $product.RegPath -Parent
    
    if(Test-Path $basePath) {
        # product exists - enforce policy
        if (!(Test-Path $product.RegPath)) {
            # FeatureLockDown key is missing
            Write-Host "FeatureLockDown key is missing in $($product.RegPath)"
            $nonCompliant = $true
            continue
        }

        try {
            # bDisableJavaScript is disabled/set to 0
            $currentValue = Get-ItemProperty -Path $product.RegPath -Name $valueName -ErrorAction Stop
            if ($currentValue.bDisableJavaScript -ne $expectedData) {
                Write-Host "bDisableJavaScript != 1 in $($product.RegPath)"
                $nonCompliant = $true
            }
        }
        catch {
            # bDisableJavaScript is missing
            Write-Host "bDisableJavaScript missing in $($product.RegPath)"
            $nonCompliant = $true
        }
    }
}

if ($nonCompliant) {
    Write-Host "Remediation required."
    exit 1
} else {
    Write-Host "Device is compliant"
    exit 0
}
