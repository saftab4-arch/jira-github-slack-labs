# Jira + GitHub + Slack — Full DevOps Integration Lab

A complete hands-on lab proving end-to-end DevOps workflow integration built from scratch.  
Every tool connected, every event traced, every notification firing in real time.

**Atlassian site:** basitusa2020.atlassian.net  
**Jira project:** DEVOPS-LAB (key: DEV)  
**GitHub repo:** github.com/saftab4-arch/jira-practice  
**Slack workspace:** jira-practice  
**Slack channels:** `#jira-alerts` (Jira events) · `#ci-alerts` (CI/CD webhook alerts)

---

## Architecture

```
┌─────────────────────────────────────────────────────────────────────┐
│                        DEVOPS INTEGRATION LOOP                      │
│                                                                     │
│   ┌──────────┐    branch/commit    ┌──────────┐                    │
│   │          │ ──────────────────► │          │                    │
│   │  Jira    │                     │  GitHub  │                    │
│   │ DEVOPS   │ ◄────────────────── │ jira-    │                    │
│   │  -LAB    │   smart commits     │ practice │                    │
│   │          │   #comment          │          │                    │
│   │ DEV-1..7 │   #time             │ branches │                    │
│   │          │   #done             │ commits  │                    │
│   └────┬─────┘                     │ PRs      │                    │
│        │                           └────┬─────┘                    │
│        │ ticket created                 │ PR merged                │
│        │ status changed                 │                          │
│        ▼                                ▼                          │
│   ┌──────────────────────────────────────────┐                     │
│   │              Slack (jira-practice)        │                     │
│   │                                          │                     │
│   │  #jira-alerts          #ci-alerts        │                     │
│   │  ┌─────────────┐      ┌──────────────┐  │                     │
│   │  │ Jira Cloud  │      │  ci-webhook  │  │                     │
│   │  │ app events  │      │  Incoming    │  │                     │
│   │  │             │      │  Webhook     │  │                     │
│   │  │ • created   │      │              │  │                     │
│   │  │ • To Do     │      │  curl POST   │  │                     │
│   │  │ • In Prog   │      │  from any    │  │                     │
│   │  │ • Done      │      │  CI/CD tool  │  │                     │
│   │  └─────────────┘      └──────────────┘  │                     │
│   └──────────────────────────────────────────┘                     │
│                                                                     │
│  ┌─────────────────────────────────────────────────────────┐       │
│  │                   AUTOMATION RULE                        │       │
│  │   GitHub PR merged  ──►  Jira ticket auto → Done        │       │
│  └─────────────────────────────────────────────────────────┘       │
└─────────────────────────────────────────────────────────────────────┘
```

---

## What this proves

- Code commits and branches are automatically traceable to Jira tickets via issue keys
- Smart commits drive Jira ticket status, comments, and time logs directly from the terminal
- Jira automation rules close tickets automatically on PR merge — no manual action needed
- Every Jira ticket event (created, transitioned) fires a real-time notification into Slack
- CI/CD alerts can be sent to Slack from any tool using a simple HTTP POST

---

## Lab overview

| Ticket | Lab | Method | Result |
|--------|-----|--------|--------|
| DEV-1 | GitHub ↔ Jira link | Branch with issue key | Branch appeared on Jira ticket |
| DEV-2 | Smart commits | `#comment` in commit message | Comment posted to Jira ticket |
| DEV-3 | Automation rule | PR merged | Ticket auto-closed by Jira |
| DEV-4 | Jira ↔ Slack | Native Slack integration | `#jira-alerts` receiving events |
| DEV-5 | Full Jira → Slack loop | Ticket transitions | All status changes firing in Slack |
| DEV-6 | Full loop test | Create + move ticket | Created + 3 transitions in Slack |
| DEV-7 | Full smart commit | `#comment #time #done` in one line | All 3 commands fired simultaneously |
| — | Slack webhook | curl POST to `#ci-alerts` | CI alert delivered via webhook |

---

## DEV-1 — GitHub ↔ Jira Linking

### What it proves
Any branch or commit containing a Jira issue key (DEV-1, DEV-2...) automatically surfaces on that ticket in Jira. No manual linking required.

### How it works
The GitHub for Jira app (installed via Atlassian Marketplace) scans all branch names, commit messages, and PR titles. When it finds an issue key, it links that code artifact to the ticket.

### Setup — connect GitHub to Jira
1. Go to **basitusa2020.atlassian.net** → **Apps** → **Explore more apps**
2. Search **GitHub for Jira** → Install
3. Authorize with your GitHub account
4. The app gets access to all repos under your GitHub organization

### Commands
```bash
# Create a branch with the issue key in the name
git switch -c DEV-1-setup-github-jira-link
# WHY: Jira scans branch names for issue keys — DEV-1 in the name links this branch to the ticket

# Create a file and commit
echo "GitHub and Jira linked via DEV-1" > setup.md
git add setup.md
git commit -m "DEV-1 link GitHub repo to Jira DEVOPS-LAB project"
# WHY: DEV-1 in the commit message also links the commit to the ticket

# Push the branch
git push origin DEV-1-setup-github-jira-link
```

### Verify
Open DEV-1 ticket in Jira → click the **branch icon** in the Development panel → branch `DEV-1-setup-github-jira-link` appears from `saftab4-arch/jira-practice`.

---

## DEV-2 — Smart Commits

### What it proves
You can post comments, log time, and transition Jira tickets to Done entirely from the terminal using special syntax in commit messages — without opening Jira.

### Critical prerequisite
The email configured in git must exactly match a verified email on your Atlassian account. If they don't match, the branch still links (matched by issue key) but all smart commit commands (`#comment`, `#time`, `#done`) are silently ignored.

```bash
# Check your git commit email
git config user.email
```

Go to **id.atlassian.com** → Profile → confirm this email is verified there.

### Smart commit syntax
```
git commit -m "ISSUE-KEY #command value"
```

| Command | Syntax | Effect |
|---------|--------|--------|
| `#comment` | `#comment your text here` | Posts a comment on the Jira ticket |
| `#time` | `#time 2h 30m` | Logs time against the ticket |
| `#done` | `#done` | Transitions ticket to Done |
| `#in-progress` | `#in-progress` | Transitions ticket to In Progress |

All commands can be chained in a single commit message.

### Commands
```bash
git switch -c DEV-2-smart-commits

echo "testing smart commits" > smart-commit-test.md
git add smart-commit-test.md

# Single command
git commit -m "DEV-2 #comment testing smart commit from terminal"

# All commands in one line
git commit --allow-empty -m "DEV-2 #comment implemented full workflow #time 1h #done"

git push origin DEV-2-smart-commits
```

### Verify
Open DEV-2 in Jira → **Comments** tab → comment appears posted by syed Aftab.  
**History** tab → To Do → Done transition logged.  
**Work log** tab → 1h logged.

---

## DEV-3 — Jira Automation Rule

### What it proves
Jira can automatically transition a ticket to Done the moment a pull request is merged on GitHub — with no `#done` command, no manual drag, nothing typed.

### Why this matters over smart commits
Smart commits require you to remember to type `#done`. The automation rule fires on the PR merge event itself. In real teams, "merged = done" is the correct definition — the work has been reviewed, approved, and shipped to main.

### Setup — create the automation rule
1. Go to your Jira project → **Project settings** (bottom left sidebar)
2. Click **Automation** → **Flows** tab → **Create flow**
3. **Choose trigger:** search "pull request" → select **Pull request merged**
4. Click **Add an action** → search "transition" → select **Transition work item**
5. **Destination status:** Done
6. Click **Save and enable**

### Commands
```bash
git switch main
git switch -c DEV-3-automation-test

echo "testing automation rule" > automation-test.md
git add automation-test.md
git commit -m "DEV-3 test automation rule PR merge closes ticket"
git push origin DEV-3-automation-test
```

Then on GitHub:
1. Go to the repo → click **Compare & pull request**
2. Open PR from `DEV-3-automation-test` → `main`
3. Click **Merge pull request** → **Confirm merge**

### Verify
Go to Jira board — DEV-3 moved to Done automatically. No manual action taken.

---

## DEV-4 — Connect Jira to Slack

### What it proves
Jira can send real-time notifications to a Slack channel whenever tickets are created or change status.

### Setup — install the Jira Cloud app in Slack
1. Open your Slack workspace → **Apps** → search **Jira Cloud**
2. Install the official Jira Cloud app by Atlassian
3. In Slack, type `/jira connect` → follow the browser OAuth flow to link your Atlassian account

### Setup — connect the project to a channel
1. Go to your Jira project → **Project settings** → **Apps** → **Slack integration**
2. Select workspace: `jira-practice`
3. Select channel: `#jira-alerts`
4. Click **Connect project**
5. Click **`...`** → **Edit** on the connection
6. Configure notifications:
   - **Issue is:** `created`
   - **Status is transitioned to:** `To Do` · `In Progress` · `Done`
   
   ⚠️ **Critical gotcha:** You must list each status explicitly. Leaving "Status is transitioned to" blank does NOT fire transition notifications — it looks like it should work but doesn't.

7. Click **Save changes**

### Verify
`#jira-alerts` in Slack shows: "syed Aftab added a project connection to this channel. DEVOPS-LAB (DEV)"  
Status: **ACTIVE**

---

## DEV-5 — Full Jira → Slack Loop

### What it proves
Every ticket event — created, moved to In Progress, moved to Done — fires a notification into `#jira-alerts` in real time with full ticket details.

### Test
1. Create a new ticket on the Jira board → watch `#jira-alerts` immediately
2. Drag the ticket To Do → In Progress → watch Slack fire
3. Drag In Progress → Done → watch Slack fire

### What appears in Slack for each event
```
@syed Aftab created a Task
DEV-6 Full loop test
Status: To Do  Type: Task  Assignee: Unassigned  Priority: Medium

@syed Aftab transitioned a Task from [To Do] → [In Progress]
DEV-6 Full loop test

@syed Aftab transitioned a Task from [In Progress] → [Done]
DEV-6 Full loop test
```

---

## DEV-7 — Full Smart Commit Workflow

### What it proves
All three smart commit commands — `#comment`, `#time`, and `#done` — can be chained in a single commit message and all fire simultaneously.

### Commands
```bash
git switch main
git switch -c DEV-7-smart-commit-full-test

echo "full smart commit test" > dev7-test.md
git add dev7-test.md

# All three commands in one commit message
git commit -m "DEV-7 #comment implemented full smart commit workflow #time 1h #done"
# WHY: Jira reads the entire commit message and processes every command it finds

git push origin DEV-7-smart-commit-full-test
```

### What fired in Jira from one commit
- Comment posted: "implemented full smart commit workflow"
- Time logged: 1h
- Status transitioned: To Do → Done
- Resolution set: Done

### Verify
Open DEV-7 → **History** tab:
- Status changed: To Do → Done
- Time spent: 0M → 1H
- Resolution: None → Done
- Development panel: 1 branch, 1 commit

---

## Slack Incoming Webhook — `#ci-alerts`

### What it proves
Any tool, script, or pipeline can send a formatted alert to a Slack channel using a single HTTP POST request. This is the primitive behind GitHub Actions, Datadog, PagerDuty, and every other CI/CD Slack integration.

### Setup — create the webhook
1. Go to **https://api.slack.com/apps**
2. Click **Create New App** → **From scratch**
3. Name: `ci-webhook` · Workspace: `jira-practice` → **Create App**
4. Click **Incoming Webhooks** in the left sidebar
5. Toggle **Activate Incoming Webhooks** to On
6. Click **Add New Webhook to Workspace**
7. Select channel: `#ci-alerts` → **Allow**
8. Copy the webhook URL: `https://hooks.slack.com/services/T.../B.../...`

### Send a CI alert
```bash
curl -X POST -H 'Content-type: application/json' \
--data '{
  "text": "*CI/CD Alert* :rocket:",
  "attachments": [{
    "color": "good",
    "fields": [
      {"title": "Result", "value": "SUCCESS", "short": true},
      {"title": "Repo", "value": "jira-practice", "short": true},
      {"title": "Branch", "value": "main", "short": true},
      {"title": "Triggered by", "value": "syed Aftab", "short": true}
    ]
  }]
}' \
https://hooks.slack.com/services/YOUR/WEBHOOK/URL
```

Terminal returns `ok` → message appears in `#ci-alerts` instantly.

### How the webhook works
The webhook URL is a unique HTTPS endpoint that accepts JSON payloads and drops them as messages into the bound Slack channel. The secret is in the URL itself — no auth header needed. This is how GitHub Actions, monitoring tools, and deployment pipelines send Slack alerts.

---

## Key concepts to explain in interviews

**Why issue keys in branch names?**  
Jira scans branch names, commit messages, and PR titles for issue keys. When found, the code is automatically linked to that ticket. No manual linking, no plugins needed beyond the GitHub app.

**Smart commits vs automation rules — when to use each?**  
Smart commits (`#done`) are manual — you type the command. Automation rules are automatic — they fire on events like PR merge. Teams use automation rules as the standard because "merged = done" is the correct signal. Smart commits are the back-pocket tool for solo work.

**Why must the Slack integration list statuses explicitly?**  
The Jira ↔ Slack integration has a known behavior: leaving "Status is transitioned to" blank does not fire transition events. Each status (To Do, In Progress, Done) must be added explicitly.

**What is an incoming webhook?**  
A unique URL that accepts HTTP POST requests with JSON payloads and delivers them as messages to a Slack channel. It is the foundation of all CI/CD alerting — GitHub Actions, Datadog, PagerDuty, and Jenkins all use this pattern.

**The full loop in one sentence:**  
A developer creates a Jira ticket, opens a branch with the ticket key in the name, commits code with smart commit commands, opens a PR — when the PR merges, the ticket closes automatically and Slack gets notified at every step.

---

## Tools and cost

All free:
- Jira Cloud free tier (basitusa2020.atlassian.net)
- GitHub free (github.com/saftab4-arch/jira-practice)
- Slack free workspace (jira-practice)
- Ubuntu Docker container (local)

---

*Part of my DevOps portfolio. See also: [AWS Networking Projects](https://github.com/saftab4-arch/aws-networking-projects)*
