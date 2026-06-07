# Lab 2 — Connect GitHub to Jira

> **Day:** Monday

## Goal
Make GitHub activity (branches, commits, PRs) appear automatically inside a Jira ticket.

**Integration taught:** GitHub -> Jira linking via issue keys in branch names.

## Steps
1. Install the **GitHub for Jira** app (official, free — Atlassian Marketplace).
2. Connect your GitHub account; grant access to this repo.
3. Grab an issue key (e.g. `PORTFOLIO-2`).
4. Create a branch named with the key: `git checkout -b PORTFOLIO-2-libreswan-config`.
5. Commit something, push the branch.
6. Open the Jira issue -> check the **Development** panel; your branch shows there.

**Done when:** Your branch appears in the Jira issue's Development panel.

> **Gotcha:** Linking is driven by the ISSUE KEY in the branch name / commit / PR title. Keep keys in branch names ALWAYS — this is the load-bearing habit for the whole week.

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
