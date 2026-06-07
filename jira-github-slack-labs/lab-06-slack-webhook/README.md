# Lab 6 — Slack incoming webhook: first manual ping

> **Day:** Wednesday

## Goal
Understand the plumbing behind every Slack notification you'll automate — the incoming webhook.

**Integration taught:** Raw Slack incoming webhook (foundation for Labs 7+).

## Steps
1. api.slack.com/apps -> Create New App -> From scratch -> pick your workspace.
2. Enable **Incoming Webhooks** -> Add New Webhook to Workspace -> point at `#ci-alerts`. Copy the URL (treat as a credential).
3. Fire a test from your terminal:
4. ```bash
curl -X POST -H 'Content-type: application/json' \
  --data '{"text":"Hello from my terminal — webhook works."}' \
  https://hooks.slack.com/services/XXXX/YYYY/ZZZZ
```

**Done when:** A curl from your terminal posts a message into Slack.

> **Gotcha:** 80% of DevOps Slack alerting is just 'POST JSON to a webhook.' Once you've done it by hand, every automated version is obvious.

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
