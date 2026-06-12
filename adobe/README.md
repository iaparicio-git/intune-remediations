# Adobe Acrobat - Policy Remediations

Detection and remediation scripts to enforce Adobe Acrobat and Acrobat Reader DC security 
policies via registry. Targets both products where applicable.

## Scripts

| Script | Purpose |
|---|---|
| `detect-disable-js.ps1` | Checks that `bDisableJavaScript` is set to `1` in the FeatureLockDown key for Reader and Acrobat. |
| `remediate-disable-js.ps1` | Creates the FeatureLockDown key if missing and sets `bDisableJavaScript = 1`. |
| `detect-disable-bflash.ps1` | Checks that `bEnableFlash` is set to `0` in the FeatureLockDown key for Reader. |
| `remediate-disable-bflash.ps1` | Sets `bEnableFlash = 0` in the FeatureLockDown key. |

## Registry Keys Targeted

| Policy | Path | Value | Expected |
|---|---|---|---|
| Disable JavaScript | `HKLM:\SOFTWARE\Policies\Adobe\Acrobat Reader\DC\FeatureLockDown` | `bDisableJavaScript` | `1` |
| Disable JavaScript | `HKLM:\SOFTWARE\Policies\Adobe\Adobe Acrobat\DC\FeatureLockDown` | `bDisableJavaScript` | `1` |
| Disable Flash | `HKLM:\SOFTWARE\Policies\Adobe\Acrobat Reader\DC\FeatureLockDown` | `bEnableFlash` | `0` |

## Notes

- Scripts check for the product base path before enforcing policy - devices without Adobe 
  installed are skipped
- Policy registry keys may persist after Adobe is uninstalled; this is harmless as the 
  keys are ignored without the software present
- JavaScript disablement driven by Microsoft Secure Score recommendation
- Flash disablement migrated from GPO
