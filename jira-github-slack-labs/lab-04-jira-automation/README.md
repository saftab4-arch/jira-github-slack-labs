# Lab 4 — Jira automation: auto-close on PR merge

> **Day:** Tuesday

## Goal
Learn automation rules — 'when X, do Y' — the no-code backbone of Jira.

**Integration taught:** Event-driven automation across GitHub -> Jira.

## Steps
1. Jira: Project settings -> Automation -> Create rule.
2. Trigger: **Pull request merged**.
3. Action: **Transition the issue to Done**.
4. Test: branch `PORTFOLIO-X-...`, open a PR, merge it, watch the ticket flip to Done.

**Done when:** Merging a PR closes its Jira ticket with zero manual steps.

> **Gotcha:** Think of an automation rule as Jira's version of an EventBridge trigger. Same mental model.

---

## My work log (fill this in as you go)

### What I did
- Built a no-code Jira automation rule (a "flow"): when a Pull Request is merged, the linked ticket auto-transitions to Done.
- Tested it cleanly: created PRAC-5 in To Do, pushed a branch with a PLAIN commit (no #done), merged the PR on GitHub — and the ticket moved to Done BY ITSELF.

### The rule I built
Trigger:  Pull request merged
Action:   Transition the work item -> DONE
(No condition needed.)
Named it "PR merge automation flow" and enabled it.

### Where to find it
Project (PRACTICE) -> lightning bolt (⚡) icon at top right, OR
- •• menu next to project name -> Project settings -> Automation -> Create rule.

### The concept (my own words)
- An automation rule = "when X happens -> do Y." Like an EventBridge rule, but for Jira.
- Here: X = "PR merged", Y = "move ticket to Done".
- The action is triggered by the MERGE EVENT itself — I don't type anything.

### Lab 3 vs Lab 4 — the key difference
- Lab 3 (#done smart commit): I MANUALLY type #done in a commit -> ticket closes. My explicit intent.
- Lab 4 (automation): a PR MERGE auto-closes the ticket. Hands-off, no typing.
- Real teams rely on Lab 4's approach: "merged into main = done" is the honest signal,
  and nobody wants to remember to type #done. Automation closes it consistently.

### Test that proved it (clean cycle)
# Ticket PRAC-5 created in To Do first.
git switch main
git pull                          # get main current after the previous merge/delete
git switch -c PRAC-5-auto-close
echo "test2" >> notes.txt
git add notes.txt
git commit -m "PRAC-5 auto close test two"   # PLAIN message — NO #done (proves automation, not smart commit)
git push -u origin PRAC-5-auto-close
# Then on GitHub: open PR -> Merge -> ticket moved To Do -> Done on its own. ✅

### Gotchas I hit
- First attempt (PRAC-4) was a bad test: the ticket was already in Done before the merge,
  so I couldn't SEE the automation move it. Lesson: the test ticket must start in To Do.
- The commit message must be PLAIN (no #done) for a valid test — otherwise the smart commit
  closes it and you can't tell whether the automation rule actually fired.
- After merging + deleting a branch, run `git switch main && git pull` before branching again
  so local main is current.
- To verify a rule fired without a visible move, check the rule's Audit log / execution history.

### Real-world note: do I type #comment/#time/#done on every commit?
- Mostly NO. In real work: key in the branch name links everything; commit messages are normal;
  the team's automation handles closing (merged = Done). Smart commits are a back-pocket tool,
  not a daily habit.

### One-line summary
> Built a "PR merged -> Done" automation rule and proved it live — PRAC-5 closed itself on merge with no #done and no dragging. This is how real teams close tickets.
