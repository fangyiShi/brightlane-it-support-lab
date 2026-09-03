# 01 — Environment Setup

Build the virtual network and the first Windows server. The original DHCP checkpoint is retained below; later notes record the server at `192.168.24.10`.

## Host and VMware

The host runs Windows 11 Home with a Ryzen 7 8845H (8 cores / 16 logical processors), 24 GB RAM and a 953.9 GB SSD. Hardware virtualization was enabled.

VMware Workstation Pro **26H1 / 26.0.0.25388281** was installed. Its application location is separate from the VM storage; the exact installed application path was not separately confirmed.

Use `D:\Projects\BrightLane-Lab` for the lab:

| Folder | Purpose |
| --- | --- |
| `ISO` | Windows installation media |
| `VirtualMachines` | VM configurations and disks |
| `Evidence` | Original screenshots and results |

D: was chosen for available space. C: and D: are on the same SSD, so this is storage organization, not a backup.

In **Edit → Preferences → Workspace**, the intended default VM folder is `D:\Projects\BrightLane-Lab\VirtualMachines`. The entered preference was recorded; persistence after reopening still needs checking.

## VMnet8 networking

Open **Edit → Virtual Network Editor** and review VMnet8:

| Setting | Lab value |
| --- | --- |
| Connection | NAT |
| Subnet / mask | `192.168.24.0/24` / `255.255.255.0` |
| Host adapter | `192.168.24.1` |
| NAT gateway | `192.168.24.2` |
| DHCP pool | `192.168.24.128–192.168.24.254` |
| DHCP service address | `192.168.24.254` |

NAT gives the VMs a shared private network and outbound access through the host. It is not complete isolation from the host's physical network.

<a href="https://raw.githubusercontent.com/fangyiShi/brightlane-it-support-lab/main/images/P1-003-host-vmnet8-baseline.png"><img src="https://raw.githubusercontent.com/fangyiShi/brightlane-it-support-lab/main/images/P1-003-host-vmnet8-baseline.png" alt="VMnet8 NAT network on subnet 192.168.24.0" width="480"></a>

The supplied host address/route review showed no overlapping private subnet. Recheck on the **host** if Wi-Fi or VPN routing changes:

```powershell
Get-NetIPAddress -AddressFamily IPv4 |
    Select-Object InterfaceAlias, IPAddress, PrefixLength
Get-NetRoute -AddressFamily IPv4 |
    Select-Object InterfaceAlias, DestinationPrefix, NextHop
```

## Create the server

1. Create a VM named `BL-DC01` and attach the Windows Server 2025 evaluation ISO.
2. Allocate **4096 MB RAM, 2 CPU cores and a 60 GB split virtual disk**. Use **Custom: VMnet8**.
3. Install a Desktop Experience image for the GUI used in this lab.
4. Set a private Administrator password, sign in, rename Windows to `BL-DC01` and restart.

The exact installed edition still needs a final readback. The intended dedicated VM folder is `VirtualMachines\BL-DC01`; a move from the parent folder was reported, but its final location is not verified. Keep all VM files together and move only while powered off.

## Initial DHCP checkpoint

The original `ipconfig /all` output shows hostname `BL-DC01`, DHCP enabled, address `192.168.24.128/24`, and gateway/DNS `192.168.24.2`.

[View the historical DHCP output](https://raw.githubusercontent.com/fangyiShi/brightlane-it-support-lab/main/images/P1-009-BL-DC01-hostname-and-dhcp-baseline.png). This is **not** the current domain-controller configuration.

## Move to a fixed server address

In the server's IPv4 adapter properties, the lab procedure used:

| Setting | Value |
| --- | --- |
| Address / mask | `192.168.24.10` / `255.255.255.0` |
| Gateway | `192.168.24.2` |
| DNS before AD/DNS | `192.168.24.2` |
| DNS after AD/DNS | Intended: `192.168.24.10`; alternate blank |

The manual address is outside the DHCP pool to reduce duplicate-allocation risk.

**Result:** later Notion notes record `192.168.24.10` and successful external name resolution. The supplied folder does not contain a final server adapter readback proving DHCP is disabled or that its DNS client now points to itself.

The [AD/DNS guide](https://github.com/fangyiShi/brightlane-it-support-lab/wiki/02-Active-Directory-and-DNS) covers the domain configuration. Final adapter settings, VMware Tools, updates/activation and VM-folder checks remain listed in [verification](https://github.com/fangyiShi/brightlane-it-support-lab/wiki/Verification-and-Troubleshooting).

## Sources

- [01 — Environment Setup — working notes (Notion; access may be required)](https://www.notion.so/3d02ac67e65681df8e05f82f750a7a43)
- Selected screenshots shown or linked above, reviewed on 3 September 2026.

- [Broadcom: virtual networking](https://knowledge.broadcom.com/external/article/309842/understanding-networking-types-in-hosted.html)
- [Microsoft: domain-controller DNS client settings](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/best-practices-for-dns-client-settings)
