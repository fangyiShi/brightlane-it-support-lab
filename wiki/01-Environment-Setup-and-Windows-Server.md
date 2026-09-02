The steps below reproduce the first server's foundation. **Verified checkpoint:** Windows boots as `BL-DC01` and obtains a DHCP lease. The final static-IP result is still outstanding in this record.

## Host and storage

The host runs Windows 11 Home with a Ryzen 7 8845H (8 cores / 16 logical processors), 24 GB RAM, and an SSD. Hardware virtualization was already enabled.

Use `D:\Projects\BrightLane-Lab` as the working directory:

| Folder | Contents |
| --- | --- |
| `Installers` | VMware installer |
| `ISO` | Windows installation media |
| `VirtualMachines` | VM configurations and virtual disks |
| `Evidence` | Original screenshots and command results |

D: has more available space than C:. They are volumes on the same SSD, so this arrangement manages capacity; it does not create a separate backup.

## VMware setup

1. Install VMware Workstation Pro for Windows using the default application path, `C:\Program Files\VMware\VMware Workstation\`.
2. Open **Help → About**. The verified version is **26H1 / 26.0.0.25388281**.
3. Under **Edit → Preferences → Workspace**, set the default VM folder to `D:\Projects\BrightLane-Lab\VirtualMachines` and save.

The application and VM files have independent storage locations. The saved record shows the entered preference; it does not separately verify persistence after reopening.

## Virtual network

Open **Edit → Virtual Network Editor**, select **VMnet8**, and inspect its NAT and DHCP settings. Retain the reviewed configuration:

| Setting | Value |
| --- | --- |
| Mode | NAT |
| Subnet / mask | `192.168.24.0/24` / `255.255.255.0` |
| Host virtual adapter | `192.168.24.1` |
| NAT gateway | `192.168.24.2` |
| DHCP pool | `192.168.24.128`–`192.168.24.254` |

NAT lets the guests share a private network and initiate outbound connections through the host. It does not completely isolate them from the physical network.

<a href="https://raw.githubusercontent.com/fangyiShi/brightlane-it-support-lab/main/images/P1-003-host-vmnet8-baseline.png"><img src="https://raw.githubusercontent.com/fangyiShi/brightlane-it-support-lab/main/images/P1-003-host-vmnet8-baseline.png" alt="VMnet8 selected with NAT, DHCP enabled and the 192.168.24.0 subnet" width="420"></a>

*VMnet8 configuration — click to view full size.*

On the **host**, inspect existing addresses and routes before retaining this subnet:

```powershell
Get-NetIPAddress -AddressFamily IPv4 |
    Select-Object InterfaceAlias, IPAddress, PrefixLength

Get-NetRoute -AddressFamily IPv4 |
    Select-Object InterfaceAlias, DestinationPrefix, NextHop
```

No conflicting private subnet appeared in the supplied host output. Recheck if Wi-Fi or VPN routing changes.

## Server installation

1. Create a new VM and choose to install the operating system later.
2. Apply the following build settings, then attach the Windows Server ISO to its virtual CD/DVD drive.
3. Boot the VM from the ISO, select a Desktop Experience image, and install onto the empty virtual disk.
4. Set the local Administrator password and sign in.
5. In **Server Manager → Local Server**, open the computer-name setting, rename Windows to `BL-DC01`, and restart.

| Build setting | Value |
| --- | --- |
| VM name / guest profile | `BL-DC01` / Windows Server 2025 |
| CPU / memory | 2 CPU cores / 4096 MB |
| Disk | 60 GB, split into multiple files |
| Adapter | Custom: VMnet8 |
| Intended dedicated folder | `D:\Projects\BrightLane-Lab\VirtualMachines\BL-DC01` |

Desktop Experience supplies the GUI used in this lab. The planned edition was Standard Evaluation; the exact installed edition still needs confirmation.

**Folder correction:** The original VM was created in the parent `VirtualMachines` folder and a manual move was reported. Move only while powered off, keep all VM files together, and reopen the `.vmx`. Select **I moved it** for the same relocated VM if prompted. The final location has not been verified.

The Windows desktop, Server Manager, and Windows hostname are verified. Installing Windows Server does not install or configure an Active Directory domain.

## Network baseline

Run `ipconfig /all` inside the **guest**. The retained result shows:

| Field | Recorded result |
| --- | --- |
| Hostname / adapter | `BL-DC01` / `Ethernet0` |
| DHCP / address | Enabled / `192.168.24.128/24` |
| Gateway / DNS | `192.168.24.2` / `192.168.24.2` |
| DHCP server | `192.168.24.254` |

<a href="https://raw.githubusercontent.com/fangyiShi/brightlane-it-support-lab/main/images/P1-009-BL-DC01-hostname-and-dhcp-baseline.png"><img src="https://raw.githubusercontent.com/fangyiShi/brightlane-it-support-lab/main/images/P1-009-BL-DC01-hostname-and-dhcp-baseline.png" alt="BL-DC01 ipconfig output showing DHCP enabled and IPv4 address 192.168.24.128" width="560"></a>

*Verified hostname and DHCP baseline — click to read the original output.*

This is the earlier DHCP checkpoint, not evidence of the proposed static address or external connectivity.

## Static address

**Procedure provided; final result not yet recorded.** In the guest, open `ncpa.cpl` → **Ethernet0 → Properties → Internet Protocol Version 4 → Properties**, then enter:

| Setting | Intended value |
| --- | --- |
| Address / mask | `192.168.24.10` / `255.255.255.0` |
| Gateway | `192.168.24.2` |
| Preferred DNS before AD/DNS | `192.168.24.2` |
| Alternate DNS | Blank |

Use an available address outside the DHCP pool to reduce duplicate-allocation risk. DHCP does not overwrite a manually assigned address. Save, then verify the result against the [acceptance checks](https://github.com/fangyiShi/brightlane-it-support-lab/wiki/Verification-and-Troubleshooting#static-address-acceptance).

When this becomes the first domain controller hosting DNS, its DNS client should point to itself at `192.168.24.10`; do not retain NAT DNS as an alternate domain DNS server. This belongs to the later AD/DNS phase.

## References

- [Broadcom: virtual networking](https://knowledge.broadcom.com/external/article/309842/understanding-networking-types-in-hosted.html)
- [Microsoft: Windows Server installation](https://learn.microsoft.com/en-us/windows-server/get-started/install-windows-server)
- [Microsoft: domain controller DNS client settings](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/best-practices-for-dns-client-settings)

[Next: verification and troubleshooting](https://github.com/fangyiShi/brightlane-it-support-lab/wiki/Verification-and-Troubleshooting)
