[README.md](https://github.com/user-attachments/files/28683149/README.md)
# Jira + GitHub + Slack Integration Labs

A one-week, hands-on build connecting **Jira** (work tracking), **GitHub** (code + CI/CD), and **Slack** (alerting + ChatOps) into a single DevOps workflow — culminating in a Terraform deploy to AWS via OIDC, with every step traceable across all three tools.

> Built by an infra/AWS engineer to demonstrate the *connected pipeline*: from a code push to a production deploy, with full cross-tool visibility.

## The three integration loops

1. **GitHub → Jira** — branches, commits, and PRs surface on the ticket; commit messages transition tickets (smart commits).
2. **Jira ↔ Slack** — ticket activity shows in Slack, and ChatOps triggers workflows back.

## Schedule (2 labs/day)

| Day | Labs | Focus |
|-----|------|-------|
| Mon | 1–2  | Jira board + GitHub↔Jira linking |
| Tue | 3–4  | Smart commits + Jira automation |
| Wed | 5–6  | Jira↔Slack + Slack webhook |
| Thu | 7–8  | Actions→Slack + full loop |
| Fri | 9–10 | ChatOps + AWS capstone |

## Labs

| # | Lab | What it proves |
|---|-----|----------------|
| 01 | [Jira board](lab-01-jira-board/) | Board fluency |
| 02 | [GitHub↔Jira link](lab-02-github-jira-link/) | Code traceability |
| 03 | [Smart commits](lab-03-smart-commits/) | Drive Jira from the CLI |
| 04 | [Jira automation](lab-04-jira-automation/) | Event-driven rules |
| 05 | [Jira↔Slack](lab-05-jira-slack/) | Notifications + create from Slack |
| 06 | [Slack webhook](lab-06-slack-webhook/) | The alerting primitive |
| 07 | [Full loop](lab-08-full-loop/) | End-to-end traceability |


## Tools & cost

All free to run: Jira Cloud free tier, free Slack workspace, GitHub free, AWS free tier.

---

*Part of my DevOps portfolio. See also my AWS networking projects (TGW hub-spoke, multi-region DR, site-to-site VPN over TGW).*
