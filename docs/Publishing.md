# Review and publish documentation

The repository is the portfolio entry point. The Wiki holds the detailed guides. Its source Markdown is kept in this repository so changes can be reviewed in a pull request.

The setup page uses the live Wiki name **01 — Environment Setup**. The older, longer URL is retained as a short navigation page so existing links still work. The publisher includes both pages and the custom sidebar.

## Review the pull request

Review the README, Wiki sources and selected screenshots together. For this Phase 1 update:

- Start with the [source index](../wiki/Home.md) and the [verification summary](../wiki/Verification-and-Troubleshooting.md).
- Follow the numbered source files below to review new pages before they exist in the live Wiki.
- New screenshots use a fixed evidence-commit URL so they can be reviewed before merging and remain tied to this evidence set.

| Source page | Content |
| --- | --- |
| [01](../wiki/01-Environment-Setup.md) | Host, VMware, networking and server |
| [02](../wiki/02-Active-Directory-and-DNS.md) | Domain controller and DNS |
| [03](../wiki/03-OUs-Users-and-Groups.md) | Directory structure and memberships |
| [04](../wiki/04-Windows-Client-and-Domain-Join.md) | Client setup and domain join |
| [05](../wiki/05-File-Shares-and-Permissions.md) | Finance access controls and tests |
| [06](../wiki/06-Group-Policy.md) | Finance drive policy |
| [07](../wiki/07-PowerShell-Administration.md) | Queries and report evidence |

Use **Create a merge commit** when merging if you want to preserve the separate evidence, documentation and publishing commits in main's history. Do not merge until you are happy with the public content.

## Publish the Wiki after merging

GitHub stores Wiki content in a separate Git repository. Merging this PR updates the source files; it does not automatically publish the Wiki. [GitHub's Wiki documentation](https://docs.github.com/en/communities/documenting-your-project-with-wikis/adding-or-editing-wiki-pages) explains this separate repository.

From a clean local checkout of this repository, using your normal Git login:

```powershell
git switch main
git pull --ff-only
.\scripts\Publish-Wiki.ps1 -Preview
.\scripts\Publish-Wiki.ps1
```

The publisher requires Git and a configured commit identity. Preview lists the files without publishing. A real run requires a clean main branch matching the latest origin/main, then copies the reviewed pages to a temporary Wiki checkout, commits and pushes normally. It keeps unrelated Wiki pages and never force-pushes.

If Git reports a conflict or authentication failure, resolve it before retrying. The temporary Wiki checkout is retained when publishing fails.

After publication, check the [Wiki home](https://github.com/fangyiShi/brightlane-it-support-lab/wiki), sidebar, new pages and screenshot links. The Wiki's own history records its publication commit.
