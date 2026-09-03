# 04 — Windows Client and Domain Join

Add a Windows 11 workstation and verify a normal domain-user sign-in.

## Client build

| Setting | Recorded configuration |
| --- | --- |
| Name | `BL-CL01` |
| Memory / CPU | 6144 MB / 2 CPU cores |
| Disk | 64 GB |
| Network | Custom: VMnet8 |
| Security device | Virtual TPM shown |
| Installation plan | Windows 11 Enterprise Evaluation, UEFI and Secure Boot |

[VM hardware summary](https://raw.githubusercontent.com/fangyiShi/brightlane-it-support-lab/5c65d9a832a02318a4287412d2d57b5fc80bf716/images/phase1/04-windows-client-and-domain-join/01-BL-CL01-vm-configuration.png) confirms memory, CPU, disk, VMnet8 and TPM. The exact installed edition and firmware settings are not shown in that image.

## Network and join

1. Install Windows and keep the local `labadmin` account for recovery.
2. Leave the client address on DHCP, but set preferred DNS to `192.168.24.10`.
3. Rename it to `BL-CL01`, then join `brightlane.test` using an authorized domain account.
4. Restart. In AD Users and Computers, move its computer object to **BrightLane → Workstations**.
5. Sign in as `BRIGHTLANEalice.wong`.

The [network screenshot](https://raw.githubusercontent.com/fangyiShi/brightlane-it-support-lab/5c65d9a832a02318a4287412d2d57b5fc80bf716/images/phase1/04-windows-client-and-domain-join/02-BL-CL01-network-configuration.png) shows DHCP enabled, address `192.168.24.129/24`, gateway `192.168.24.2`, DHCP server `192.168.24.254` and DNS `192.168.24.10`. The address is a lease and may change; the screenshot is a pre-join network checkpoint.

## Verification result

System Properties confirms `BL-CL01.brightlane.test` and membership in `brightlane.test`.

<a href="https://raw.githubusercontent.com/fangyiShi/brightlane-it-support-lab/5c65d9a832a02318a4287412d2d57b5fc80bf716/images/phase1/04-windows-client-and-domain-join/03-BL-CL01-domain-membership.png"><img src="https://raw.githubusercontent.com/fangyiShi/brightlane-it-support-lab/5c65d9a832a02318a4287412d2d57b5fc80bf716/images/phase1/04-windows-client-and-domain-join/03-BL-CL01-domain-membership.png" alt="BL-CL01 System Properties confirming brightlane.test domain membership" width="560"></a>

*Click the screenshot to view full size.*

- [Workstations OU](https://raw.githubusercontent.com/fangyiShi/brightlane-it-support-lab/5c65d9a832a02318a4287412d2d57b5fc80bf716/images/phase1/04-windows-client-and-domain-join/04-BL-CL01-workstations-ou.png) contains BL-CL01.
- [Alice's account screen](https://raw.githubusercontent.com/fangyiShi/brightlane-it-support-lab/5c65d9a832a02318a4287412d2d57b5fc80bf716/images/phase1/04-windows-client-and-domain-join/05-BL-CL01-alice-domain-login.png) shows the domain identity `BRIGHTLANEalice.wong`.
- A supplied UAC screenshot asks for administrator credentials. It is consistent with an elevation boundary, but is not a full check of local Administrators membership.

No administrator password is included in the documentation.

## Sources

- [04 — Windows Client and Domain Join — working notes (Notion; access may be required)](https://www.notion.so/3d02ac67e656812c9e36c6095b578357)
- Selected screenshots shown or linked above, reviewed on 3 September 2026.


[Next: file shares and permissions](https://github.com/fangyiShi/brightlane-it-support-lab/wiki/05-File-Shares-and-Permissions)
