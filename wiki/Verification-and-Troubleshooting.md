# Verification and Troubleshooting

Reviewed on **3 September 2026** against the Phase 1 Notion chapters and supplied screenshots. The newer evidence resolves several items still marked unverified in Notion; Notion itself was not edited.

## Current results

| Area | What is established | Limit |
| --- | --- | --- |
| Environment | Server boots as BL-DC01; VMnet8 NAT and initial DHCP output recorded | Final server adapter and storage checks remain open |
| AD and DNS | brightlane.test, BL-DC01 Global Catalog; simple and recursive DNS tests pass | DC DNS client and forwarder settings not shown |
| Directory objects | Four BrightLane OUs; Alice and Ben enabled; Alice in Finance and recursively in the resource group | Exact group scopes, intermediate nesting and Ben's HR membership not shown |
| Client | BL-CL01 domain membership, Workstations OU, Alice sign-in, DNS .10 | Installed edition and firmware settings not shown |
| Permissions | Finance share and NTFS entries; saved test file; access-denied dialog | Test images do not identify the signed-in users; deletion reported only |
| Group Policy | Alice's gpresult lists BL-User-Finance-Drive; F: and no-F: images supplied | Drive images do not show identity; full drive-item settings not shown |
| PowerShell | AD query results and CSV contents visible | Saved script source, execution and full report path not shown |
| Troubleshooting exercise | Guidance recorded | Alice's Account-tab checks and a documented fault/fix/retest are still pending |

Each [chapter](https://github.com/fangyiShi/brightlane-it-support-lab/wiki) links the supporting evidence. A filename helps identify the intended test, but does not prove a result that is absent from the image.

## Remaining checks

These are follow-up checks, not claims that the lab is broken. No VMs were changed or tests rerun during this documentation review.

### Server networking

Inside BL-DC01, compare `ipconfig /all` with the intended final configuration:

| Field | Expected |
| --- | --- |
| IPv4 / mask | `192.168.24.10` / `255.255.255.0` |
| DHCP enabled | No |
| Gateway | `192.168.24.2` |
| Preferred DNS | `192.168.24.10`; alternate blank |

The notes record .10 and external name resolution. DNS monitoring now has passing evidence, but it does not show the DNS forwarder address. Read the Forwarders tab to confirm the intended `192.168.24.2`.

For an outbound TCP check, use the correctly spelled hostname:

```powershell
Test-NetConnection -ComputerName www.microsoft.com -Port 443
```

Expected: `TcpTestSucceeded : True`. An earlier test used `www.microdoft.com`; that result does not verify Microsoft connectivity. No successful correctly spelled TCP result is supplied.

### Identity, access and automation

- Confirm group scope/category and the direct member of DL-Finance-Modify. Check Ben's GG-HR membership.
- Pair Alice's successful file operations and Ben's denied access with `whoami` in their respective sessions.
- Confirm F: points to `\\BL-DC01\Finance` for Alice, and record Ben's identity alongside the no-drive result.
- Inspect the saved Export-ADUsers.ps1 and run it inside the guest before marking the script tested.
- Complete the planned Alice Account-tab checks: disabled, locked-out and expiry state. Record a real or deliberately prepared lab incident, its fix and a retest.

### Environment housekeeping

The final server/client editions, client firmware settings, final VM folder, saved VMware folder preference, VMware Tools/clipboard, Windows updates/activation and recovery baseline are not all verified. Keep these separate from the successful domain and access checks.

## Troubleshooting cases

### Finance access initially denied

**Symptom:** Alice could not open the Finance share.

**Checks/action in the notes:** inspect group membership and the resource-group nesting, then sign out and sign back in to refresh the session.

**Result:** the learner reported create/read/edit/delete working afterwards; the supplied image shows the test file and contents.

**Limit:** the original membership state and complete retest sequence were not captured. Incomplete nesting is a possible explanation, not a confirmed root cause.

### Finance drive not visible in the Network view

The notes describe looking at the Network page and seeing a discovery message. The relevant checks are **This PC**, the user's applied GPOs and item-level targeting. A later image shows Finance F:.

Do not treat the Network discovery banner as proof that the drive policy failed, or change discovery/firewall settings solely because of that banner.

### Server clock concern

The learner reported the clock moving backwards and later said the issue was resolved after a settings check. The exact cause and before/after time-source state are not established. A file's LastWriteTime is not the same as the current system clock.

## Support record format

For the next incident, record **symptom → checks → action → retest → remaining limits**. Keep administrator passwords, recovery passwords and real-user data out of screenshots.

## Sources

- [08 — Troubleshooting, Notion working notes](https://www.notion.so/3d02ac67e65681e2b5ebf65172aee2b9)
- [09 — Verification and Documentation, Notion working notes](https://www.notion.so/3d02ac67e656814980cbd40bc3dc5c02)
- [Phase 1 source index](https://www.notion.so/3cc2ac67e65681168046eea4e65a86fe) and evidence linked in guides 01–07. Notion access may be required.

[Back to Wiki home](https://github.com/fangyiShi/brightlane-it-support-lab/wiki/)
