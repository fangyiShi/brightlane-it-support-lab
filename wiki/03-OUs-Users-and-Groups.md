# 03 — OUs, Users and Groups

Organize lab objects and assign access through groups instead of individual user permissions.

## Directory structure

Create the following OUs in Active Directory Users and Computers. Keep `BL-DC01` in the existing **Domain Controllers** OU.

```text
brightlane.test
├── Domain Controllers
│   └── BL-DC01
└── BrightLane
    ├── Users
    ├── Groups
    ├── Workstations
    │   └── BL-CL01
    └── Servers
```

The four BrightLane OUs are screenshot-confirmed:

<a href="https://raw.githubusercontent.com/fangyiShi/brightlane-it-support-lab/5c65d9a832a02318a4287412d2d57b5fc80bf716/images/phase1/03-ous-users-and-groups/01-BL-DC01-ou-structure.png"><img src="https://raw.githubusercontent.com/fangyiShi/brightlane-it-support-lab/5c65d9a832a02318a4287412d2d57b5fc80bf716/images/phase1/03-ous-users-and-groups/01-BL-DC01-ou-structure.png" alt="BrightLane OU with Users, Groups, Workstations and Servers" width="560"></a>

*Click the screenshot to view full size.*

## Accounts and group design

| Object | Purpose / intended configuration |
| --- | --- |
| Alice Wong / `alice.wong` | Finance user |
| Ben Taylor / `ben.taylor` | HR user for the comparison test |
| `GG-Finance` | Global security group for Finance users |
| `GG-HR` | Intended global security group for HR users |
| `DL-Finance-Modify` | Domain-local security group for Finance folder access |

Create user accounts in **BrightLane → Users** and groups in **BrightLane → Groups**. Give each account a private password. Add Alice to GG-Finance; the planned HR membership is Ben in GG-HR.

The intended Finance access chain is:

```text
alice.wong → GG-Finance → DL-Finance-Modify → Finance folder permissions
```

OUs organize objects and provide policy scope. Security groups are used to assign resource access. The GG/DL prefixes describe the intended group scope; their names alone do not verify that setting.

## Recorded result

- [The AD user query](https://raw.githubusercontent.com/fangyiShi/brightlane-it-support-lab/5c65d9a832a02318a4287412d2d57b5fc80bf716/images/phase1/07-powershell-administration/01-BL-DC01-ad-user-query.png) shows Alice and Ben enabled.
- [The direct GG-Finance query](https://raw.githubusercontent.com/fangyiShi/brightlane-it-support-lab/5c65d9a832a02318a4287412d2d57b5fc80bf716/images/phase1/07-powershell-administration/02-BL-DC01-finance-group-membership.png) shows Alice as a member.
- [The recursive DL-Finance-Modify query](https://raw.githubusercontent.com/fangyiShi/brightlane-it-support-lab/5c65d9a832a02318a4287412d2d57b5fc80bf716/images/phase1/07-powershell-administration/03-BL-DC01-finance-recursive-membership.png) resolves to Alice.

The recursive query confirms Alice is reachable through the resource group, but does not show intermediate groups. A direct DL-Finance-Modify membership query is still needed to prove the exact nesting. Group scopes and Ben's GG-HR membership also remain unverified.

## Sources

- [03 — OUs, Users and Groups — working notes (Notion; access may be required)](https://www.notion.so/3d02ac67e656818da131c7699731c366)
- Selected screenshots shown or linked above, reviewed on 3 September 2026.

- [Microsoft: AD security groups and scopes](https://learn.microsoft.com/en-us/windows-server/identity/ad-ds/manage/understand-security-groups)

[Next: Windows client and domain join](https://github.com/fangyiShi/brightlane-it-support-lab/wiki/04-Windows-Client-and-Domain-Join)
