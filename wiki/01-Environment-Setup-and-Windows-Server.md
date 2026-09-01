# 01 — Environment Setup and Windows Server

This page records the work completed before configuring Active Directory. It covers the host, VMware, virtual networking, the first server VM and the latest verified network result.

## 1. Host preparation

The host was checked before creating the lab.

| Item | Result |
| --- | --- |
| Operating system | Windows 11 Home, 64-bit |
| Processor | AMD Ryzen 7 8845H, 8 physical cores and 16 logical processors |
| Memory | 24 GB DDR5 installed, 23.3 GB usable |
| Storage | 953.9 GB SSD |
| Hardware virtualization | Enabled |
| Working folder | `D:\Projects\BrightLane-Lab` |

VM files and ISO images are stored on `D:` because it has more free space than `C:`. VMware itself can remain installed on `C:` because the application location and VM storage location are separate settings.

## 2. VMware setup

VMware Workstation Pro 26H1, version 26.0.0.25388281, was installed and opened successfully. The intended VM storage folder is:

```text
D:\Projects\BrightLane-Lab\VirtualMachines
```

This keeps the large virtual disks away from the smaller system partition.

## 3. Virtual networking

VMnet8 NAT was selected for the lab.

![VMnet8 network configuration](https://raw.githubusercontent.com/fangyiShi/brightlane-it-support-lab/main/images/P1-003-host-vmnet8-baseline.png)

| Setting | Value |
| --- | --- |
| Network type | NAT |
| Subnet | `192.168.24.0/24` |
| Subnet mask | `255.255.255.0` |
| Host virtual adapter | `192.168.24.1` |
| NAT gateway | `192.168.24.2` |
| DHCP pool | `192.168.24.128` to `192.168.24.254` |

NAT allows the lab machines to communicate with each other and use the host's connection for updates. The host routing table was reviewed and no overlapping route for `192.168.24.0/24` was found at that checkpoint.

The planned server address, `192.168.24.10`, is inside the subnet but outside the VMware DHCP pool. This reduces the risk that VMware DHCP will lease the same address to another guest. An address outside the pool must still be checked because it is not automatically unused.

## 4. Server creation

The first virtual machine was prepared with these settings:

| Setting | Value |
| --- | --- |
| Name | `BL-DC01` |
| Operating system | Windows Server 2025 Evaluation |
| CPU | 2 cores |
| Memory | 4 GB |
| Virtual disk | 60 GB, split into multiple files |
| Network adapter | Custom VMnet8 |
| Intended folder | `D:\Projects\BrightLane-Lab\VirtualMachines\BL-DC01` |

![BL-DC01 configuration reference](https://raw.githubusercontent.com/fangyiShi/brightlane-it-support-lab/main/images/P1-006-BL-DC01-vm-wizard-configuration.png)

The screenshot above is an edited configuration reference with the intended folder corrected. It records the build settings, but it is not proof that the manually moved VM folder was reopened and verified in VMware.

Windows Server reached the desktop and Server Manager. The Windows hostname was confirmed as `BL-DC01`. Installing Windows Server alone does not make it a domain controller; Active Directory Domain Services must be installed and configured later.

## 5. Initial server networking

The latest saved output shows that Ethernet0 received a valid lease from VMware DHCP.

![BL-DC01 hostname and DHCP baseline](https://raw.githubusercontent.com/fangyiShi/brightlane-it-support-lab/main/images/P1-009-BL-DC01-hostname-and-dhcp-baseline.png)

| Setting | Verified result |
| --- | --- |
| Hostname | `BL-DC01` |
| Adapter | Ethernet0 |
| DHCP enabled | Yes |
| IPv4 address | `192.168.24.128` |
| Subnet mask | `255.255.255.0` |
| Default gateway | `192.168.24.2` |
| DHCP server | `192.168.24.254` |
| DNS server | `192.168.24.2` |

This confirms a working DHCP lease on VMnet8. It does not prove external name resolution, internet access, static configuration or domain services.

## 6. Planned static configuration

The next planned settings are:

| Setting | Planned value |
| --- | --- |
| IPv4 address | `192.168.24.10` |
| Prefix/subnet mask | `/24` or `255.255.255.0` |
| Default gateway | `192.168.24.2` |
| Temporary DNS during standalone setup | `192.168.24.2` |
| DNS after domain-controller setup | `192.168.24.10` |

These values are plans, not verified results. After the server becomes the first domain controller and hosts DNS, its DNS client should point to the server itself instead of using the VMware NAT DNS address as an alternate domain DNS server.

## 7. Verification still required

- Confirm the VM opens from its intended folder after the manual move.
- Install and verify VMware Tools and shared clipboard support.
- Configure and verify the static IP address.
- Check Windows updates, activation and installed edition details.
- Install and verify Active Directory Domain Services and DNS.

