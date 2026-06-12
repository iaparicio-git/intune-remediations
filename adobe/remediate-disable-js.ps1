# Adobe Reader/Acrobat Disable JS - Remediation Script
# sets bDisableJavaScript to 1 for Adobe Reader and Adobe Acrobat DC

$readerPath = "HKLM:\SOFTWARE\Policies\Adobe\Acrobat Reader\DC\FeatureLockDown"
$acrobatPath = "HKLM:\SOFTWARE\Policies\Adobe\Adobe Acrobat\DC\FeatureLockDown"
$valueName = "bDisableJavaScript"
$valueType = "DWORD"
$valueData = 1

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
    # check if product base path exists (product installed)
    $basePath = Split-Path $product.RegPath -Parent
    
    if (Test-Path $basePath) {
        # ensure FeatureLockDown key exists
        if (!(Test-Path $product.RegPath)) {
            New-Item -Path $product.RegPath -Force | Out-Null
        }
    
        # set bDisableJavaScript to 1
        New-ItemProperty `
        -Path $product.RegPath `
        -Name $valueName `
        -Value $valueData `
        -PropertyType $valueType `
        -Force | Out-Null
    }
}
