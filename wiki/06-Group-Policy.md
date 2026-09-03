# 06 — Group Policy

Map the Finance share to **F:** for Finance users, without mapping it for other users.

## Configure the preference

The notes record a GPO named `BL-User-Finance-Drive` linked to **BrightLane → Users**.

Edit **User Configuration → Preferences → Windows Settings → Drive Maps**:

| Setting | Lab value |
| --- | --- |
| Action | Update |
| Location | `\\BL-DC01\Finance` |
| Drive letter / label | F: / Finance |
| Reconnect | Enabled |
| Common tab | Item-level targeting enabled |
| Target | User in `BRIGHTLANE\GG-Finance` |
| Primary group | Not selected |

The [targeting screenshot](https://raw.githubusercontent.com/fangyiShi/brightlane-it-support-lab/5c65d9a832a02318a4287412d2d57b5fc80bf716/images/phase1/06-group-policy/01-BL-DC01-finance-drive-targeting.png) confirms **User in group** and GG-Finance. The GPO link and the drive item's General settings are recorded in notes rather than shown in that screenshot.

A user can receive the GPO without meeting the drive item's targeting condition. Item-level targeting controls the mapping; the share and NTFS permissions control access.

## Verify in the user's session

```powershell
whoami
gpupdate /target:user /force
gpresult /scope user /r
```

Open **This PC**, not just the Network view, to check mapped drives.

## Recorded results

<a href="https://raw.githubusercontent.com/fangyiShi/brightlane-it-support-lab/5c65d9a832a02318a4287412d2d57b5fc80bf716/images/phase1/06-group-policy/03-BL-CL01-alice-gpresult.png"><img src="https://raw.githubusercontent.com/fangyiShi/brightlane-it-support-lab/5c65d9a832a02318a4287412d2d57b5fc80bf716/images/phase1/06-group-policy/03-BL-CL01-alice-gpresult.png" alt="Alice's gpresult showing BL-User-Finance-Drive in applied Group Policy Objects" width="560"></a>

*Click the screenshot to view full size.*

- Alice's gpresult identifies her domain user object and lists **BL-User-Finance-Drive** as applied.
- [Finance F: is visible](https://raw.githubusercontent.com/fangyiShi/brightlane-it-support-lab/5c65d9a832a02318a4287412d2d57b5fc80bf716/images/phase1/06-group-policy/02-BL-CL01-alice-finance-mapped-drive.png) in the image labelled as Alice's test. This image alone does not show the user or UNC target.
- [No Finance drive is visible](https://raw.githubusercontent.com/fangyiShi/brightlane-it-support-lab/5c65d9a832a02318a4287412d2d57b5fc80bf716/images/phase1/06-group-policy/04-BL-CL01-ben-no-finance-drive.png) in the image labelled as Ben's test. It does not include his signed-in identity.

The evidence supports the policy deployment and the recorded drive outcomes. A same-session identity check would strengthen the Alice/Ben comparison. A Network discovery banner alone is not a reason to change firewall or discovery settings.

## Sources

- [06 — Group Policy — working notes (Notion; access may be required)](https://www.notion.so/3d02ac67e65681d9970ec253fbdd4cce)
- Selected screenshots shown or linked above, reviewed on 3 September 2026.
- [Microsoft: Group Policy Preferences and targeting](https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn581922%28v=ws.11%29)


[Next: PowerShell administration](https://github.com/fangyiShi/brightlane-it-support-lab/wiki/07-PowerShell-Administration)
