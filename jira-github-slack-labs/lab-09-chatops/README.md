# Lab 9 — ChatOps: trigger a deploy from Slack

> **Day:** Friday

## Goal
Go beyond notifications into actions — kick off a GitHub workflow from Slack.

**Integration taught:** Slack -> GitHub (ChatOps), closing the loop both directions.

## Steps
1. Add a `workflow_dispatch` (and/or `repository_dispatch`) trigger to a workflow.
2. Use a Slack workflow (Workflow Builder) or slash command that calls GitHub's API (`repository_dispatch`).
3. Type the trigger in Slack -> the Action runs -> posts back the result.
4. Keep it safe: run `terraform plan` (read-only), not a blind apply.

**Done when:** A message in Slack starts a GitHub Actions run and reports back.

> **Gotcha:** Never wire Slack to a blind `terraform apply`. plan-only keeps the demo safe and is the responsible pattern to show interviewers.

---

## My work log (fill this in as you go)

### What I did
- 

### Commands / config that actually worked
```
(paste the real commands, YAML, or rule config here)
```

### Screenshots
<!-- drop images in ./screenshots and reference them: -->
<!-- ![description](screenshots/your-screenshot.png) -->

### Gotchas I hit
- 

### One-line summary for the Friday README / LinkedIn post
> 
