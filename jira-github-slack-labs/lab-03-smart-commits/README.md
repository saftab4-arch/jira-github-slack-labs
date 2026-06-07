# Lab 3 — Smart commits: drive Jira from the terminal

> **Day:** Tuesday

## Goal
Comment on, log time against, and close a Jira ticket straight from `git commit` — never opening Jira.

**Integration taught:** GitHub -> Jira write actions via commit messages.

## Steps
1. Set git email to match your Jira email: `git config --global user.email "<jira-email>"` (email must be public on GitHub).
2. Comment: `git commit -m "PORTFOLIO-2 #comment tunnel up, BGP routes exchanged"`
3. Log time: `git commit -m "PORTFOLIO-2 #time 2h validated connectivity"`
4. Transition: `git commit -m "PORTFOLIO-2 #close done, README pushed"`
5. Combine on one line: `git commit -m "PORTFOLIO-2 #time 1h #comment cleanup #close"`
6. Push, wait ~1 min, refresh the ticket.

**Done when:** One commit message moves a ticket to Done and logs time, hands-off.

> **Gotcha:** The transition word (#close/#done) must match a real transition in your workflow. If #close does nothing, check the ticket's status button names.

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
