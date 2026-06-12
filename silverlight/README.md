# Detect and Remove Microsoft Silverlight in Intune

PowerShell scripts for Intune (Scripts and remediations) to automatically detect and silently uninstall Microsoft Silverlight from managed Windows endpoints.

## Background

Microsoft Silverlight reached End of Support in October 2021 and should no longer be present on managed devices. These scripts were created to address cases where Silverlight was being installed by developers, and automate its removal across the environment without user interaction.

## Scripts

| Script | Purpose |
|---|---|
| `detection.ps1` | Detects if Silverlight is installed via registry. Exits `1` (non-compliant) if found, `0` (compliant) if not. |
| `remediation.ps1` | Locates the Silverlight MSI product code from the registry and silently uninstalls using `msiexec /x`. |

## How It Works

Both scripts check the following registry paths to support both 32-bit and 64-bit installations:

- `HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*`
- `HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*`

The detection script looks for any entry where `DisplayName` matches `*silverlight*`. If found, it reports non-compliant and triggers remediation. The remediation script pulls the MSI product code (`PSChildName`) from the same registry key and runs a silent uninstall.

## Deployment

1. In the [Intune admin center](https://intune.microsoft.com), go to **Devices > Scripts and remediations**
2. Create a new Remediation package
3. Upload `detection.ps1` and `remediation.ps1`
4. Set **Run this script using the logged-on credentials** to **No** (runs as SYSTEM)
5. Set **Run script in 64-bit PowerShell** to **Yes**
6. Assign to your target device group - safe to assign to all devices

## Notes

- Silent uninstall only (`/qn`) - no user-facing prompts
- Safe to deploy broadly; if Silverlight is not installed the detection script exits cleanly
- Targets both standard and WOW6432Node registry keys to catch 32-bit installs on 64-bit systems
- Scripts sanitized for public sharing. Originally written for use in a managed enterprise environment.
