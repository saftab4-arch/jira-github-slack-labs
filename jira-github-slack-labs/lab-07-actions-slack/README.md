# Lab 7 — GitHub Actions -> Slack: CI notifications

> **Day:** Thursday

## Goal
Build a real CI workflow that posts pass/fail to Slack.

**Integration taught:** GitHub Actions -> Slack (the core CI/CD notification pattern).

## Steps
1. Repo: Settings -> Secrets and variables -> Actions -> add secret `SLACK_WEBHOOK_URL` (from Lab 6). Never hardcode it.
2. The workflow lives at repo root: `.github/workflows/ci.yml` (stub already in this repo).
3. Run something real (terraform fmt/validate or a bash lint), then notify Slack via `slackapi/slack-github-action@v2.0.0`.
4. Push a passing commit, then a deliberately broken one. Watch both land in `#ci-alerts`.

**Done when:** Both a green and a red pipeline post their status to Slack.

> **Gotcha:** Use `if: always()` on the notify step so failures still report. Without it, a failed build stays silent.

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
