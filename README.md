# Bright Lane IT Support Lab

A hands-on Windows infrastructure lab for a fictional Australian retailer. It demonstrates account support, domain-joined devices, controlled file access, Group Policy and basic PowerShell reporting.

**Phase 1:** the domain and client are working, Finance permissions are configured, and policy/reporting evidence is recorded. Final verification and a structured troubleshooting exercise remain open.

[Wiki home](https://github.com/fangyiShi/brightlane-it-support-lab/wiki/) · [Setup guide](https://github.com/fangyiShi/brightlane-it-support-lab/wiki/01-Environment-Setup-and-Windows-Server) · [Results and remaining checks](https://github.com/fangyiShi/brightlane-it-support-lab/wiki/Verification-and-Troubleshooting)

## Environment

| Component | Lab configuration |
| --- | --- |
| Host | Windows 11 Home, Ryzen 7 8845H, 24 GB RAM |
| Virtualization | VMware Workstation Pro 26H1 |
| Network | VMnet8 NAT, `192.168.24.0/24` |
| Server | `BL-DC01`, Windows Server 2025, AD DS and DNS |
| Domain | `brightlane.test` / `BRIGHTLANE` |
| Client | `BL-CL01`, Windows 11, joined to the domain |
| Access example | Finance share and F: drive for the Finance group |

## What the evidence shows

- A domain controller, organized OUs, enabled Alice and Ben accounts, and Finance group membership.
- A joined client using domain DNS, with an Alice domain sign-in.
- Finance share/NTFS permissions and a saved access-test file.
- The Finance GPO applied to Alice, a Finance drive screenshot, and a CSV user report.

Ben's denial/no-drive screenshots do not include his identity. The saved export script has not been independently verified. These limits stay visible in the [verification guide](https://github.com/fangyiShi/brightlane-it-support-lab/wiki/Verification-and-Troubleshooting).

## Documentation

The Wiki contains the detailed steps, actual settings, decisions and evidence. [Browse its source pages](wiki/Home.md) to review proposed changes before publication.

Selected lab screenshots are in `images/`. Original evidence, VM disks, installation media and credentials stay out of Git. No reusable AD administration script is claimed as tested yet.

Documentation changes go through pull requests. After merging, publish the reviewed Wiki sources using the [publishing guide](docs/Publishing.md).
