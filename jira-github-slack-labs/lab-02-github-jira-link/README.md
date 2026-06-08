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
- Installed the "GitHub for Atlassian" app (by Atlassian) from the Jira Apps marketplace.
- Connected my GitHub account (saftab4-arch) — account-level connection, all repos.
- Created a branch named with the issue key: POR-6-add-waf, made a commit.
- Branch + commit auto-appeared in the ticket's Development panel — no manual linking.


### Commands / config that actually worked
```POR-6-add-waf

Ticket → In Progress → branch (PRAC-1-add-config) → commit → PR (OPEN) → merge → PR (MERGED) + file lands in main → Done
- PR OPEN → MERGED is how the ticket knows the work reached main.
- Merging puts the branch's file into main; the feature branch is then deleted (disposable).
- Moving the ticket to Done is still MANUAL → this is what Lab 4 will automate.

### Gotchas I hit
-  GitHub connection is account-level, not per-project. Connect once → every Jira project sees all repos. No reconnecting for new projects.
- Jira's Development panel syncs on a delay — branch/PR show fast, commit count can lag a few minutes. The commit was on GitHub the whole time; just a sync delay.
- Branch name only needs the KEY to match (e.g. POR-7); the rest of the name is for humans. Name it descriptively in real work (POR-7-cloudwatch-alarms, not -add-waf leftover).


### One-line summary for the Friday README / LinkedIn post
> 
Connected GitHub to Jira and ran a ticket end-to-end — branch → commit → PR → merge → main — watching it sync to the ticket the whole way.
