# 07 — PowerShell Administration

Use simple read-only AD queries and export a user list. Run these in PowerShell **inside BL-DC01**, with the Active Directory module available.

## Query users

```powershell
Get-ADUser -Filter * |
    Select-Object Name, SamAccountName, Enabled
```

[The supplied result](https://raw.githubusercontent.com/fangyiShi/brightlane-it-support-lab/5c65d9a832a02318a4287412d2d57b5fc80bf716/images/phase1/07-powershell-administration/01-BL-DC01-ad-user-query.png) shows Alice Wong and Ben Taylor enabled. Built-in accounts also appear because the query includes all users.

## Check Finance membership

```powershell
Get-ADGroupMember -Identity 'GG-Finance' |
    Select-Object Name, SamAccountName, ObjectClass

Get-ADGroupMember -Identity 'DL-Finance-Modify' -Recursive |
    Select-Object Name, SamAccountName, ObjectClass
```

Both [the direct Finance query](https://raw.githubusercontent.com/fangyiShi/brightlane-it-support-lab/5c65d9a832a02318a4287412d2d57b5fc80bf716/images/phase1/07-powershell-administration/02-BL-DC01-finance-group-membership.png) and [the recursive resource-group query](https://raw.githubusercontent.com/fangyiShi/brightlane-it-support-lab/5c65d9a832a02318a4287412d2d57b5fc80bf716/images/phase1/07-powershell-administration/03-BL-DC01-finance-recursive-membership.png) return Alice. Recursive output finds leaf members; it does not show the intermediate nesting path.

To check that missing detail, a future read-only check is:

```powershell
Get-ADGroupMember -Identity 'DL-Finance-Modify' |
    Select-Object Name, SamAccountName, ObjectClass
```

The intended direct member is GG-Finance. This check's result is not supplied.

## Export a user report

The notes record a manual export to `C:\LabReports\AD-users.csv`. The repeatable command sequence is:

```powershell
New-Item -ItemType Directory -Path 'C:\LabReports' -Force | Out-Null
Get-ADUser -Filter * |
    Select-Object Name, SamAccountName, Enabled |
    Export-Csv -Path 'C:\LabReports\AD-users.csv' -NoTypeInformation -Encoding UTF8
Import-Csv -Path 'C:\LabReports\AD-users.csv'
```

This intentionally replaces the report at that path when rerun. Keep exports inside the lab and review their contents before sharing.

<a href="https://raw.githubusercontent.com/fangyiShi/brightlane-it-support-lab/5c65d9a832a02318a4287412d2d57b5fc80bf716/images/phase1/07-powershell-administration/04-BL-DC01-ad-user-report-verification.png"><img src="https://raw.githubusercontent.com/fangyiShi/brightlane-it-support-lab/5c65d9a832a02318a4287412d2d57b5fc80bf716/images/phase1/07-powershell-administration/04-BL-DC01-ad-user-report-verification.png" alt="AD-users.csv opened in Notepad with Name, SamAccountName and Enabled columns" width="560"></a>

*Click the screenshot to view full size.*

**Verified:** a file titled AD-users.csv is open with the expected columns and five account rows. The screenshot does not show its full path or the export command.

The notes also describe a prepared `C:\LabReports\Export-ADUsers.ps1`. Its actual source file and execution evidence were not supplied, so it is not included here as a tested script. Verify the saved file before treating it as reusable automation.

## Sources

- [07 — PowerShell Administration — working notes (Notion; access may be required)](https://www.notion.so/3d02ac67e65681e5b2b1fc87da4ab44e)
- Selected screenshots shown or linked above, reviewed on 3 September 2026.

- [Microsoft: Get-ADGroupMember and recursive membership](https://learn.microsoft.com/en-us/powershell/module/activedirectory/get-adgroupmember?view=windowsserver2025-ps)

[Next: verification and troubleshooting](https://github.com/fangyiShi/brightlane-it-support-lab/wiki/Verification-and-Troubleshooting)
