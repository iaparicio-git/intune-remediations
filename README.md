# Intune Remediations

PowerShell detection and remediation script packages deployed via Microsoft Intune (Scripts and 
Remediations) to detect and enforce configuration compliance across managed Windows endpoints.

## Background

These scripts were created to address configuration drift, security recommendations, and legacy 
software removal across a managed environment. Each package consists of a detection script that 
reports compliance state and a remediation script that corrects it when non-compliant.

## Structure

Each remediation has its own folder with its own README covering script details and context:

```
intune-remediations/
├── silverlight/
│   ├── README.md
│   ├── detect-silverlight.ps1
│   └── remediate-silverlight.ps1
└── adobe/
    ├── README.md
    ├── detect-disable-js.ps1
    └── remediate-disable-js.ps1
```

## Deployment

1. In the [Intune admin center](https://intune.microsoft.com), go to **Devices > Scripts and remediations**
2. Create a new Remediation package
3. Upload the detection and remediation scripts from the relevant folder
4. Set **Run this script using the logged-on credentials** to **No** (runs as SYSTEM)
5. Set **Run script in 64-bit PowerShell** to **Yes**
6. Assign to your target device group

## Notes

- Scripts sanitized for public sharing. Originally written for use in a managed enterprise environment.
- See each folder's README for script-specific details and context
