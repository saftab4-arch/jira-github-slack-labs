# Lab 1 — Stand up Jira & build your first board

> **Day:** Monday

## Goal
Get comfortable in Jira so the rest stops feeling foreign. No integration yet — pure orientation.

**Integration taught:** Jira fundamentals: project, issue types, board, statuses.

## Steps
1. Sign up for Jira Cloud free tier (free up to 10 users).
2. Create a project named `PORTFOLIO`. Pick the **Kanban** template.
3. Take a real AWS project (e.g. Site-to-Site VPN over TGW) and break it into 6+ issues.
4. Drag a couple of cards across To Do -> In Progress -> Done.

**Done when:** A `PORTFOLIO` board with 6+ issues and at least one moved to Done.

> **Gotcha:** Don't overthink issue types. Task = a doable chunk. Epic = a big theme. That's enough for now.

---

## My work log (fill this in as you go)

### What I did
- - Created a Jira Cloud free-tier site (basitusa2020.atlassian.net).
- Made a team-managed project "PORTFOLIO" (key: POR) using the Kanban template.
- Cleaned the default template: removed service-desk work types (Incident, Service Request, Support), kept Task; set statuses to To Do / In Progress / Done.
- Added 8 issues mapping to my real AWS-Cloudflare-Security-Lab project (5 already-built → Done, 3 future enhancements → To Do).

### Commands / config that actually worked
```
(paste the real commands, YAML, or rule config here)
```
No CLI — all done in the Jira web UI.
- Template choice: Kanban (continuous flow), team-managed.

### Gotchas I hit
- Landed on a service-management template by accident first (had Incident/Service Request/Waiting for Customer). Trashed it and recreated as Kanban.
- The project key is what matters for GitHub linking, NOT the display name. URL showed "KAN" early but actual issue keys are POR-1...POR-8. Always confirm the key from a card, not the URL.
- Renamed "Resolved" → "Done" because smart commits (#close) and automation target a status literally named "Done".


### One-line summary for the Friday README / LinkedIn post
> 
Built a real Kanban board in Jira from my AWS-Cloudflare-Security-Lab project — 8 tickets, proper To Do/In Progress/Done flow.
