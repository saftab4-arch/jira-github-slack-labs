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

Created a dedicated #ci-alerts channel for build/pipeline alerts (separate from #jira).
Created a Slack app ci-webhook at api.slack.com/apps using From scratch in the portfolio-jira workspace.
Enabled Incoming Webhooks, clicked Add New Webhook to Workspace, pointed it at #ci-alerts, and minted the webhook URL (stored as a secret — redacted everywhere as XXXX/YYYY/ZZZZ).
Installed curl in the Ubuntu Docker container (it wasn't present), then fired two POSTs: a simple text message and a production-shaped Block Kit CI alert.
Confirmed both landed in #ci-alerts (terminal returned ok on each).
- 

### Commands / config that actually worked
```
# curl was missing from the base container:
apt update && apt install -y curl

# Simple message:
curl -X POST -H 'Content-type: application/json' \
  --data '{"text":"Hello from the container — webhook works! :rocket:"}' \
  https://hooks.slack.com/services/XXXX/YYYY/ZZZZ
# -> Slack responds: ok

# Block Kit message (this is the shape Lab 7's GitHub Action will send):
curl -X POST -H 'Content-type: application/json' \
  --data '{
    "text": "*Deploy pipeline finished* :white_check_mark:",
    "blocks": [
      {
        "type": "section",
        "text": { "type": "mrkdwn", "text": "*CI/CD Result:* `SUCCESS`\n*Repo:* AWS-Cloudflare-Security-Lab\n*Branch:* `main`" }
      }
    ]
  }' \
  https://hooks.slack.com/services/XXXX/YYYY/ZZZZ
```


### Gotchas I hit
- curl not installed in the base container — fixed with apt update && apt install -y curl.
Curly apostrophe in the JSON text can break shell quoting — use a straight ' or avoid apostrophes in the test message.
ok glued to the prompt — Slack's success response has no trailing newline, so it appears stuck to the next shell prompt (e.g. okroot@host:). Normal, not an error.
The webhook URL is a credential — never commit it, never leave it in a screenshot. Redact as XXXX/YYYY/ZZZZ; in Lab 7 it goes into GitHub Secrets as SLACK_WEBHOOK_URL.

### One-line summary for the Friday README / LinkedIn post
> Built a Slack incoming webhook and fired it from the terminal with curl — both a plain message and a Block Kit CI alert — proving the POST-JSON-to-a-URL primitive that every automated Slack notification (including Lab 7's GitHub Actions) is built on.
