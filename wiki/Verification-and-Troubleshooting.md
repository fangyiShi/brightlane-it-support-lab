Use these checks after setup or a network change. Run commands in **Windows PowerShell inside `BL-DC01`**, unless a step specifically names the host.

## Recorded baseline

```powershell
hostname
ipconfig /all
```

The retained output confirms `BL-DC01`, DHCP enabled, `192.168.24.128/24`, and gateway/DNS `192.168.24.2`. DHCP leases may change; `.128` is the observed address at that checkpoint.

## Static-address acceptance

After applying the planned static settings, inspect `ipconfig /all` again:

| Field | Expected result |
| --- | --- |
| Host Name | `BL-DC01` |
| DHCP Enabled | No |
| IPv4 Address | `192.168.24.10` |
| Subnet Mask | `255.255.255.0` |
| Default Gateway | `192.168.24.2` |
| DNS Servers | `192.168.24.2` during standalone setup |

**Status:** the later command was reported as run, but its output has not been added to this record. These are acceptance criteria, not a reported pass.

## Outbound connectivity check

```powershell
Test-NetConnection -ComputerName www.microsoft.com -Port 443
```

**Pass:** `TcpTestSucceeded : True`. The command tests a TCP connection to that destination; it does not prove every internet service or Windows Update works. [Microsoft command reference](https://learn.microsoft.com/en-us/powershell/module/nettcpip/test-netconnection)

**Status:** additional check proposed; result not recorded. If it fails, use the table below and retain the output before changing settings.

## Troubleshooting

| Symptom | First checks and next action |
| --- | --- |
| PowerShell command is not recognised | Open Windows PowerShell, not CMD; check the spelling. |
| Guest has no usable address | In VMware, confirm the adapter is connected to VMnet8. Check `ipconfig /all` for DHCP state and address. |
| Guest address exists, but outbound traffic fails | Check the subnet, gateway, host connectivity, and VMware NAT service; verify DNS if name resolution fails. |
| Name lookup fails in the TCP check | Run `nslookup www.microsoft.com`; inspect the configured DNS server and its response. Successful DNS alone does not prove TCP connectivity. |
| Address changes between sessions | If DHCP is enabled, a changing lease is possible. For the planned static configuration, check that DHCP is disabled. |
| VM fails to open after a move | Find the actual `.vmx` and all split disk files. Reopen the VM from that folder; record the exact missing-file error if one remains. |
| Clipboard transfer fails | Check VMware Tools in the guest and **VM Settings → Options → Guest Isolation → Enable copy and paste**. |
| VM becomes slow | On the host, inspect Task Manager memory, CPU, and disk use before increasing allocations. |

Record each actual incident as **symptom → checks/results → change → retest**. A failed ping alone is not proof of a disconnected network; ICMP may be filtered.

## Remaining validation

- Confirm the final VM folder and exact Windows edition.
- Retain the post-static-IP result.
- Check VMware Tools, clipboard sharing, updates, and activation.
- Establish a recoverable baseline before AD DS changes.
- Add DNS, domain-join, sign-in, and permissions tests when those components exist.

Testing currently consists of manual infrastructure checks. Automated tests and code coverage are not present in this project.

[Back to setup](https://github.com/fangyiShi/brightlane-it-support-lab/wiki/01-Environment-Setup-and-Windows-Server)
