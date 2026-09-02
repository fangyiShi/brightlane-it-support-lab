# Bright Lane IT Support Lab

A Windows infrastructure lab for a fictional Australian retailer. It demonstrates virtual machine setup, network configuration, and the foundation for account, device, and access support using Active Directory.

**Current milestone:** `BL-DC01` boots into Windows Server and has a verified hostname and DHCP lease. Active Directory and the client workstation are upcoming.

[Setup guide](https://github.com/fangyiShi/brightlane-it-support-lab/wiki/01-Environment-Setup-and-Windows-Server) · [Verification and troubleshooting](https://github.com/fangyiShi/brightlane-it-support-lab/wiki/Verification-and-Troubleshooting) · [Wiki home](https://github.com/fangyiShi/brightlane-it-support-lab/wiki)

## Requirements and installation

| Component | Version or configuration used |
| --- | --- |
| Host | Windows 11 Home, 64-bit; hardware virtualization enabled |
| Hardware | Ryzen 7 8845H, 24 GB RAM, SSD storage |
| Hypervisor | VMware Workstation Pro 26H1, version 26.0.0.25388281 |
| Guest installation media | Windows Server 2025 Evaluation ISO; Desktop Experience for a GUI |
| Server resources | 2 CPU cores, 4 GB RAM, 60 GB virtual disk |
| Commands | Built-in Windows PowerShell and Windows networking tools |

These are the chosen lab settings. Leave host memory and storage available for installation media and snapshots.

Install [VMware Workstation Pro](https://knowledge.broadcom.com/external/article/368667/download-and-license-vmware-desktop-hype.html), obtain the [Windows Server evaluation ISO](https://www.microsoft.com/en-us/evalcenter/evaluate-windows-server-2025), then follow the setup guide to create the VM. The verification commands use built-in Windows tools; no additional packages are required.

## Start and configure the lab

1. Open VMware Workstation and select `BL-DC01`. If it is not listed, use **File → Open** to select its existing `.vmx` file under `D:\Projects\BrightLane-Lab\VirtualMachines`.
2. Check that its network adapter uses **Custom: VMnet8** and is connected.
3. Power on the VM and sign in using its local Administrator account.
4. Open **Windows PowerShell inside the guest** and run the verification commands below.

Configuration lives in the local `.vmx` file and Windows settings. No `.env` is needed. Shut down Windows inside the guest after a session.

| Network setting | Lab value |
| --- | --- |
| VMnet8 subnet / gateway | `192.168.24.0/24` / `192.168.24.2` |
| Last evidenced guest address | `192.168.24.128` via DHCP; leases can change |
| Intended static address | `192.168.24.10/24`; final result not yet recorded |
| DNS before AD/DNS setup | `192.168.24.2` |

## Verification and tests

This phase uses manual infrastructure checks. An automated test suite has not yet been implemented.

Run inside `BL-DC01`:

```powershell
hostname
ipconfig /all
```

**Recorded result:** hostname `BL-DC01`, DHCP enabled, IPv4 `192.168.24.128/24`, gateway and DNS `192.168.24.2`. External connectivity and domain services remain unverified.

For a repeatable outbound connectivity check:

```powershell
Test-NetConnection -ComputerName www.microsoft.com -Port 443
```

**Pass condition:** `TcpTestSucceeded : True`. Its result has not been recorded. See the [verification guide](https://github.com/fangyiShi/brightlane-it-support-lab/wiki/Verification-and-Troubleshooting) for failure handling and static-IP acceptance criteria.

## Completed and planned work

| Work | State |
| --- | --- |
| Host assessment, VMware installation, VMnet8 and route review | Completed |
| Windows Server installation, hostname, initial DHCP lease | Completed |
| Static-IP result, final VM path, Tools, updates and activation checks | Verification outstanding |
| AD DS and DNS; OUs, users and groups | Planned |
| Windows client and domain join | Planned |
| File permissions, Group Policy and support incidents | Planned |

## Improvements

- Automate repeatable configuration and network checks with PowerShell.
- Add DNS, domain-join, sign-in, and permissions integration checks as features are implemented.
- Establish a recoverable baseline and a separate backup strategy.
- Monitor host memory and disk use before expanding beyond this small, representative environment.

## Troubleshooting and operating notes

Start with the [troubleshooting table](https://github.com/fangyiShi/brightlane-it-support-lab/wiki/Verification-and-Troubleshooting#troubleshooting): check the VM adapter, addressing, gateway, and DNS before investigating higher-level services. Record the symptom, check result, change, and retest.

Keep all files together when relocating a powered-off VM. The final folder and installed edition still need confirmation. Keep passwords, product keys, installation media, and VM disks out of Git.

## Documentation files

`wiki/` contains Wiki Markdown sources; `images/` contains selected screenshots. The Wiki uses a separate Git repository. To publish the reviewed sources with your local Git login, run:

```powershell
.\scripts\Publish-Wiki.ps1
```

The publisher requires Git and a configured commit identity. It preserves other Wiki pages and uses a normal push.
