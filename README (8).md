# Jira + GitHub + Slack Integration Labs

A hands-on lab series proving end-to-end DevOps workflow integration across Jira, GitHub, and Slack.  
Built as part of the Train with Shubham 90DaysOfDevOps program.

**Atlassian site:** basitusa2020.atlassian.net  
**Primary project:** PORTFOLIO (POR)  
**Sandbox project:** PRACTICE (PRAC)  
**Slack workspace:** portfolio-jira  
**GitHub:** github.com/saftab4-arch/jira-github-slack-labs

---

## What this proves

A working DevOps pipeline where:
- Code commits and PRs are traceable back to Jira tickets
- Jira ticket status changes are visible in Slack in real time
- Automation closes tickets on PR merge without manual intervention
- Slack receives CI/CD alerts via incoming webhooks
- Tickets can be created from Slack without opening Jira

---

## Labs completed

| # | Lab | Focus |
|---|-----|-------|
| 01 | Jira board setup | Board fluency, ticket lifecycle |
| 02 | GitHub ↔ Jira linking | Code traceability |
| 03 | Smart commits | Drive Jira from the terminal |
| 04 | Jira automation | Event-driven rules, PR merge → auto-close |
| 05 | Jira ↔ Slack | Bidirectional notifications + create from Slack |
| 06 | Slack incoming webhook | The alerting primitive |
| 08 | Full Jira → Slack loop | Status transitions firing in real time |

---

## Lab 01 — Jira Board Setup

### What I did
- Created a Jira Cloud free-tier Kanban project named **PORTFOLIO** (key: POR)
- Created a sandbox project **PRACTICE** (key: PRAC) for testing without affecting the main board
- Populated POR with real tickets from my AWS-Cloudflare-Security-Lab project
- Moved tickets across columns (To Do → In Progress → Done) to understand the board lifecycle

### Why it matters
Jira is the source of truth for work in DevOps teams. Every branch, commit, PR, and deploy traces back to a ticket. Understanding the board is the foundation for everything else in this series.

### Key concepts
- **Project key** (POR, PRAC) — prefixes every issue number (POR-1, POR-2...)
- **Kanban vs Scrum** — Kanban has no sprints; work flows continuously
- **Issue types** — Task, Bug, Story, Epic; we used Task throughout

---

## Lab 02 — GitHub ↔ Jira Linking

### What I did
- Installed the **GitHub for Jira** app from the Atlassian Marketplace
- Connected my GitHub account to basitusa2020.atlassian.net
- Linked the AWS-Cloudflare-Security-Lab repo and the jira-github-slack-labs repo to the POR project
- Created a branch named `POR-6-add-waf-integration` and proved the branch appeared on the POR-6 ticket in Jira automatically

### Why it matters
This is code traceability — a senior engineer or auditor can open any Jira ticket and see exactly which branches, commits, and PRs relate to it. No manual linking required; the issue key in the branch name does it automatically.

### How the linking works
Jira scans branch names, commit messages, and PR titles for issue keys (POR-6, PRAC-2, etc.).  
If the key is present, the code is automatically surfaced on that ticket.

### Critical detail
The GitHub app must be authorized at **both** the workspace level (OAuth install) and the user level (`/jira connect` in Slack or the Jira sidebar). Two separate auth steps — missing either one breaks the link.

---

## Lab 03 — Smart Commits

### What I did
- Set up SSH keys inside the Ubuntu Docker container and cloned the jira-practice repo
- Verified that `git config user.email` matched a verified email on my Atlassian account (the critical prerequisite)
- Drove a Jira ticket entirely from the terminal using smart commit syntax — never opened Jira

### Commands and why

```bash
# Create a branch with the issue key in the name
git switch -c PRAC-2-smart-commit-test
# WHY: the key in the branch name links the branch to the ticket automatically

# Smart commit — add a comment to the Jira ticket
git commit -m "PRAC-2 #comment added nginx config"
# WHY: #comment posts directly to the ticket's comment thread in Jira

# Smart commit — log time against the ticket
git commit -m "PRAC-2 #time 1h"
# WHY: #time logs work against the ticket for time tracking

# Smart commit — transition the ticket to Done
git commit -m "PRAC-2 #done"
# WHY: #done moves the ticket to Done status without opening Jira

# Push the branch
git push origin PRAC-2-smart-commit-test
```

### Critical prerequisite
The email on git commits must exactly match a verified email on the Atlassian account.  
If they don't match, the branch still links (matched by key) but `#comment`, `#time`, and `#done` are silently ignored.

```bash
# Check your commit email
git config user.email
git log -1 --format='%ae'
```

### Available smart commit commands
| Command | Effect |
|---------|--------|
| `#comment <text>` | Posts a comment on the ticket |
| `#time <1h 30m>` | Logs time against the ticket |
| `#done` | Transitions the ticket to Done |
| `#in-progress` | Transitions the ticket to In Progress |

---

## Lab 04 — Jira Automation

### What I did
- Built a no-code automation rule in Jira: **Pull request merged → Transition issue to Done**
- Proved it by creating ticket PRAC-5, opening a branch, committing, opening a PR, merging it — PRAC-5 moved to Done automatically with no `#done` command typed

### How to create the rule
1. Go to your Jira project → **Project settings** → **Automation**
2. Click **Create rule**
3. **Trigger:** Pull request merged
4. **Action:** Transition issue → Done
5. Save and enable the rule

### Lab 03 vs Lab 04 — why both exist

| | Lab 03 `#done` | Lab 04 automation |
|---|---|---|
| What triggers it | You typing `#done` in a commit | A PR being merged |
| When it fires | The moment you commit | The moment work hits main |
| Who decides | You, manually | The system, automatically |
| Real-world fit | Quick solo work | Team workflow (the standard) |

In real teams, **Lab 04's approach is the standard**. Nobody wants to remember to type `#done`, and "merged = done" is the honest definition of finished work — it's been reviewed, approved, and shipped to main.

---

## Lab 05 — Jira ↔ Slack Bidirectional Integration

### What I did
- Created `#jira` channel in the portfolio-jira Slack workspace
- Installed the official **Jira Cloud app by Atlassian** into the workspace
- Completed the two-layer OAuth handshake:
  - Layer 1: workspace-level install (admin installs the app)
  - Layer 2: user-level connect (`/jira connect` in Slack → browser OAuth)
- Connected the POR project to `#jira`
- Configured notification events: issue created, status transitioned
- Proved three event types firing into Slack:
  - Ticket created in Jira → message in `#jira`
  - `/jira create` from Slack → ticket landed on POR board as POR-9 and POR-10
  - Status transitions posting with from→to badges in `#jira`

### Key gotcha discovered
In the Slack ↔ Jira notification settings, the **"Status is transitioned to"** field must have statuses listed explicitly:  
✅ To Do, In Progress, Done  
❌ Leaving it blank does NOT fire transition notifications — it looks like it should work but doesn't

### The two-layer OAuth — why it exists
- **Layer 1** gives the app permission to post into channels (workspace admin action)
- **Layer 2** tells Jira which Atlassian user account is making the request (your personal auth)  
Both are required. Missing Layer 2 means `/jira` commands work but ticket events don't appear.

---

## Lab 06 — Slack Incoming Webhook

### What I did
- Created a Slack app named **ci-webhook** (App ID: A0B9KSUU8DA) at api.slack.com
- Enabled Incoming Webhooks and minted a webhook URL bound to `#ci-alerts`
- Installed curl inside the Ubuntu Docker container
- Fired a plain text POST and a structured Block Kit CI alert payload to `#ci-alerts`
- Both returned `ok` and messages appeared in the channel

### Commands and why

```bash
# Install curl in the Ubuntu Docker container
apt update && apt install -y curl
# WHY: curl is the tool for making HTTP POST requests to the webhook URL

# Send a plain text test message
curl -X POST -H 'Content-type: application/json' \
  --data '{"text":"Hello from Syeds container — webhook works!"}' \
  https://hooks.slack.com/services/YOUR/WEBHOOK/URL

# Send a structured CI alert with fields
curl -X POST -H 'Content-type: application/json' \
  --data '{
    "text": "CI/CD Alert",
    "attachments": [{
      "color": "good",
      "fields": [
        {"title": "CI/CD Result", "value": "SUCCESS", "short": true},
        {"title": "Repo", "value": "AWS-Cloudflare-Security-Lab", "short": true},
        {"title": "Branch", "value": "main", "short": true}
      ]
    }]
  }' \
  https://hooks.slack.com/services/YOUR/WEBHOOK/URL
```

### What an incoming webhook is
A unique HTTPS URL that accepts JSON POST requests and drops the payload as a message into a specific Slack channel. No auth header needed — the secret is in the URL itself. This is the primitive that GitHub Actions, CI/CD pipelines, and monitoring tools (PagerDuty, Datadog, etc.) use to send alerts into Slack.

### Where to find the webhook URL
api.slack.com → Your Apps → ci-webhook → Incoming Webhooks

---

## Lab 08 — Full Jira → Slack Loop

### What I did
- Verified the Jira ↔ Slack connection was ACTIVE on the PORTFOLIO project (Slack integration tab)
- Confirmed notification triggers were configured: issue created + status transitioned to To Do / In Progress / Done
- Created test ticket POR-11 "This is a test ticket" — fired instantly into `#jira`
- Dragged POR-11 from To Do → In Progress — transition notification fired into `#jira` in real time

### How to configure the Jira → Slack notifications
1. Go to your Jira project → **Slack integration** tab
2. Click **...** → **Edit** on the connected channel
3. Under **"Send a message to the channel when"**:
   - Issue is: `created`
   - Status is transitioned to: `To Do`, `In Progress`, `Done` *(must list explicitly)*
4. Click **Save changes**

### What fires in Slack
Every notification in `#jira` shows:
- Who triggered it (@syed Aftab)
- What happened (created / transitioned from X → Y)
- Ticket number and title (POR-11 This is a test ticket)
- Status, Type, Assignee, Priority

### The full loop proven end to end
```
Ticket created in Jira  →  #jira notified instantly
Ticket moved To Do → In Progress  →  #jira notified instantly
Ticket moved In Progress → Done  →  #jira notified instantly
/jira create from Slack  →  ticket appears on Jira board
```

---

## Key takeaways

- Jira issue keys (POR-6, PRAC-2) in branch names and commit messages are what wire code to tickets — no manual linking needed
- Smart commits (`#done`, `#comment`, `#time`) drive Jira from the terminal but require git email to match Atlassian email exactly
- Automation rules (PR merged → Done) are the team-standard way to close tickets — no one types `#done` on real teams
- The Jira ↔ Slack OAuth has two layers; missing either one breaks the integration silently
- The "Status is transitioned to" field must list statuses explicitly — blank does not fire
- Incoming webhooks are the primitive behind every CI/CD Slack alert — one URL, one POST, one message

---

## Tools and cost

All free to run:
- Jira Cloud free tier
- Free Slack workspace
- GitHub free tier
- Ubuntu Docker container (local)

---

*Part of my DevOps portfolio. See also: [AWS Networking Projects](https://github.com/saftab4-arch/aws-networking-projects)*
