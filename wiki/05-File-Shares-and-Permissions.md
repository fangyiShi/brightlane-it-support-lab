# 05 — File Shares and Permissions

Provide Finance users with shared storage at `\\BL-DC01\Finance`, backed by `C:\Shares\Finance`.

This small lab hosts the share on the domain controller to keep the VM count low. It is a learning setup, not a production deployment design.

## Access design

Use the group chain documented in [OUs, users and groups](https://github.com/fangyiShi/brightlane-it-support-lab/wiki/03-OUs-Users-and-Groups). Assign the folder permissions to DL-Finance-Modify, not directly to Alice.

| Layer | Principal | Configuration |
| --- | --- | --- |
| Share | DL-Finance-Modify | Allow Change and Read |
| Share | Administrators | Present; Full Control intended, selected rights not shown |
| NTFS | DL-Finance-Modify | Allow Modify |
| NTFS | Administrators and SYSTEM | Allow Full Control |

1. Create `C:\Shares\Finance` and share it as **Finance**.
2. In Advanced Sharing permissions, remove the broad Everyone entry and give DL-Finance-Modify Change and Read. Retain administrative access.
3. In the folder's advanced Security settings, disable inheritance and convert the inherited entries.
4. Remove broad Users and CREATOR OWNER entries. Retain SYSTEM and Administrators, and apply the resource group's Modify permission to this folder, subfolders and files.

Both share and NTFS permissions matter for network access; a mapped drive does not bypass them.

## Permission evidence

The [share permissions image](https://raw.githubusercontent.com/fangyiShi/brightlane-it-support-lab/5c65d9a832a02318a4287412d2d57b5fc80bf716/images/phase1/05-file-shares-and-permissions/01-BL-DC01-finance-share-permissions.png) shows Change and Read for DL-Finance-Modify and no Everyone entry.

<a href="https://raw.githubusercontent.com/fangyiShi/brightlane-it-support-lab/5c65d9a832a02318a4287412d2d57b5fc80bf716/images/phase1/05-file-shares-and-permissions/02-BL-DC01-finance-ntfs-permissions.png"><img src="https://raw.githubusercontent.com/fangyiShi/brightlane-it-support-lab/5c65d9a832a02318a4287412d2d57b5fc80bf716/images/phase1/05-file-shares-and-permissions/02-BL-DC01-finance-ntfs-permissions.png" alt="Finance NTFS permissions showing Administrators and SYSTEM Full Control and DL-Finance-Modify Modify" width="560"></a>

*Click the screenshot to view full size.*

The NTFS screenshot confirms the three intended entries, inheritance disabled, and application to the folder, subfolders and files.

## Access tests

| Test | Result and limit |
| --- | --- |
| Alice opens and saves a test file | [Saved test file and its contents](https://raw.githubusercontent.com/fangyiShi/brightlane-it-support-lab/5c65d9a832a02318a4287412d2d57b5fc80bf716/images/phase1/05-file-shares-and-permissions/03-BL-CL01-alice-finance-write-test.png) are visible in Finance. The image does not show the signed-in identity. |
| Alice creates, reads, edits and deletes | Reported successful in Notion after access recovery; deletion is not captured in the supplied image. |
| Ben attempts the UNC path | [Access-denied dialog](https://raw.githubusercontent.com/fangyiShi/brightlane-it-support-lab/5c65d9a832a02318a4287412d2d57b5fc80bf716/images/phase1/05-file-shares-and-permissions/04-BL-CL01-ben-finance-access-denied.png) is visible. The file is labelled as Ben's test, but the image does not include his identity. |

For a stronger final comparison, pair each result with `whoami` in the same signed-in session. No new test was run during this documentation review.

Alice initially received an access error. The notes describe checking group nesting and refreshing the sign-in, followed by success. Incomplete nesting is a possible cause, not a proven root cause; the original membership state was not recorded.

## Sources

- [05 — File Shares and Permissions — working notes (Notion; access may be required)](https://www.notion.so/3d02ac67e6568159b4bbc02e929b2e58)
- Selected screenshots shown or linked above, reviewed on 3 September 2026.


[Next: Group Policy](https://github.com/fangyiShi/brightlane-it-support-lab/wiki/06-Group-Policy)
