# Lab 10 — Capstone: deploy to AWS with full observability

> **Day:** Friday

## Goal
One resume-grade project tying everything to real AWS infra, the secure way.

**Integration taught:** All three integrations against live AWS, with secure OIDC auth.

## Steps
1. Terraform deploys real AWS infra you know (VPC, or extend your TGW hub-spoke).
2. GitHub Actions auths to AWS via **OIDC federation** — no long-lived keys (the security signal that impresses).
3. Pipeline: `plan` on PR, `apply` on merge to main.
4. Jira tracks it as a small epic with sub-tasks, run as one 'sprint' (this week).
5. Slack gets CI results, deploy success/failure, ideally a drift-detection run.
6. Write the top-level README + LinkedIn post.

**Done when:** A PR merge deploys AWS infra via OIDC, Jira tracking it, Slack reporting every step — all documented.

> **Gotcha:** OIDC (no static AWS keys in GitHub) is the single most impressive detail here for a DevSecOps target. Don't skip it for convenience.

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
