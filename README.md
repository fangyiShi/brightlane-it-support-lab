# Bright Lane IT Support Lab

Bright Lane is a practical home lab for building and explaining common Level 1 and Level 2 IT support skills. The current phase focuses on VMware, Windows Server and the foundation for an Active Directory environment.

## Current status

The first Windows Server virtual machine is running.

- Server name: `BL-DC01`
- Operating system: Windows Server 2025 Evaluation
- Virtual platform: VMware Workstation Pro 26H1
- Lab network: VMnet8 NAT, `192.168.24.0/24`
- Current verified address: `192.168.24.128` from VMware DHCP
- Static server address: planned as `192.168.24.10`, not yet verified
- Active Directory and DNS roles: upcoming

The existing DHCP result confirms that the server is connected to VMnet8. It does not yet prove that the planned static address, Active Directory or DNS services are working.

## Environment overview

| Component | Configuration |
| --- | --- |
| Host | Windows 11 laptop, AMD Ryzen 7 8845H, 24 GB RAM |
| Hypervisor | VMware Workstation Pro 26H1, version 26.0.0.25388281 |
| Server VM | `BL-DC01`, 2 CPU cores, 4 GB RAM, 60 GB virtual disk |
| Network | VMnet8 NAT, `192.168.24.0/24` |
| Working folder | `D:\Projects\BrightLane-Lab` |

## Progress

| Area | Status |
| --- | --- |
| Host and storage preparation | Completed |
| VMware and VMnet8 review | Completed |
| Windows Server installation and hostname | Completed |
| Static server networking | In progress |
| Active Directory Domain Services and DNS | Upcoming |
| Organisational units, users and groups | Upcoming |
| Windows client and domain join | Upcoming |
| File shares, Group Policy and support exercises | Upcoming |

## Documentation

- [Wiki Home](https://github.com/fangyiShi/brightlane-it-support-lab/wiki)
- [01 — Environment Setup and Windows Server](https://github.com/fangyiShi/brightlane-it-support-lab/wiki/01-Environment-Setup-and-Windows-Server)

The Wiki contains the setup details, important decisions and verified results. Documentation is updated as the lab develops, and planned work is kept separate from completed work.

## Safety and scope

ISO files, virtual machine disks, installers and local configuration files are not stored in this repository. Only selected screenshots and reusable scripts are included.
