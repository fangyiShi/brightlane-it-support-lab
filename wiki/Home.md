# Bright Lane IT Support Lab

This Wiki records the setup and verification of a small Windows support lab. The goal is to practise the work commonly handled by Level 1 and Level 2 IT support teams, then explain each decision clearly.

## Current position

Phase 1 is in progress. VMware and the lab network have been reviewed, and the first Windows Server virtual machine is running as `BL-DC01`.

The server currently has a verified DHCP address of `192.168.24.128`. The planned static address, Active Directory and DNS roles have not yet been verified.

## Setup guide

- [01 — Environment Setup and Windows Server](01-Environment-Setup-and-Windows-Server)

## Environment at a glance

| Item | Value |
| --- | --- |
| Host | Windows 11 laptop |
| Hypervisor | VMware Workstation Pro 26H1 |
| Server | Windows Server 2025 Evaluation |
| Server name | `BL-DC01` |
| Lab network | VMnet8 NAT, `192.168.24.0/24` |
| Current verified IP | `192.168.24.128` from DHCP |
| Planned static IP | `192.168.24.10` |

## Upcoming work

1. Configure and verify the static server address.
2. Complete VMware Tools, updates and activation checks.
3. Install Active Directory Domain Services and DNS.
4. Create the domain structure, users and security groups.
5. Build and join a Windows client.
6. Add file shares, Group Policy and troubleshooting exercises.

