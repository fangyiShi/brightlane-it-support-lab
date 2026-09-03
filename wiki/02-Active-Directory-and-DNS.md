# 02 — Active Directory and DNS

Turn `BL-DC01` into the domain controller and DNS server for `brightlane.test`.

## Configuration

1. In Server Manager, install **Active Directory Domain Services** with its management tools.
2. Promote the server into a new forest named `brightlane.test`. The NetBIOS domain is `BRIGHTLANE`.
3. Keep DNS and Global Catalog enabled. Set a private Directory Services Restore Mode password, complete the prerequisite checks and restart.
4. Use the domain Administrator account for domain administration.

| Item | Lab value |
| --- | --- |
| Domain controller | `BL-DC01` |
| Domain | `brightlane.test` |
| Server address | `192.168.24.10`, recorded in notes |
| Intended server DNS client | `192.168.24.10`, alternate blank |
| Intended DNS forwarder | `192.168.24.2` |

Domain members use domain DNS to locate AD services. The first DC's DNS client should use its own address; external queries can be forwarded by the DNS service. The client screenshot confirms DNS `192.168.24.10`, but the DC's own DNS settings and forwarder tab still need a final readback.

## Verification result

AD Users and Computers shows `brightlane.test` and `BL-DC01` in **Domain Controllers**, with DC type **GC**.

<a href="https://raw.githubusercontent.com/fangyiShi/brightlane-it-support-lab/5c65d9a832a02318a4287412d2d57b5fc80bf716/images/phase1/02-active-directory-and-dns/01-ad-domain-controller.png"><img src="https://raw.githubusercontent.com/fangyiShi/brightlane-it-support-lab/5c65d9a832a02318a4287412d2d57b5fc80bf716/images/phase1/02-active-directory-and-dns/01-ad-domain-controller.png" alt="brightlane.test domain and BL-DC01 global catalog in Domain Controllers" width="560"></a>

*Click the screenshot to view full size.*

In **DNS Manager → BL-DC01 → Properties → Monitoring**, both the simple and recursive tests show **Pass**. [View DNS monitoring results](https://raw.githubusercontent.com/fangyiShi/brightlane-it-support-lab/5c65d9a832a02318a4287412d2d57b5fc80bf716/images/phase1/02-active-directory-and-dns/02-dns-monitoring-passed.png).

This confirms those DNS tests passed at that checkpoint. It does not prove the configured forwarder is `192.168.24.2`, because the Forwarders tab is not shown.

## Sources

- [02 — Active Directory and DNS — working notes (Notion; access may be required)](https://www.notion.so/3d02ac67e656810ca5e9ffe0f28eb4d9)
- Selected screenshots shown or linked above, reviewed on 3 September 2026.

- [Microsoft: DNS client settings for domain controllers](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/best-practices-for-dns-client-settings)

[Next: OUs, users and groups](https://github.com/fangyiShi/brightlane-it-support-lab/wiki/03-OUs-Users-and-Groups)
