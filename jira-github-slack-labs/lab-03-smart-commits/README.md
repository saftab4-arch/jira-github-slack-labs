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

- Set up SSH keys in my Ubuntu Docker container and cloned jira-practice.
- Matched + verified my git commit email with my Atlassian account (the critical step).
- Drove a Jira ticket entirely from the terminal using smart commits: comment, log time, and transition to Done — never opened Jira.

### Critical prerequisite (the make-or-break)
- The email on my git commits MUST match a VERIFIED email on my Atlassian account.
- If they don't match, the branch/commit still shows on the ticket (matched by key), but the smart-commit COMMANDS (#comment/#time/#done) are silently ignored.
- Check with: git config user.email   and   git log -1 --format='%ae'

### Setup: SSH key inside the Docker container, then clone
# NOTE: the container is a SEPARATE machine from Windows — it needs its own SSH key.
# (Kept my Windows key too; GitHub allows multiple keys per account.)

# 1. Check for an existing key in the container
ls -la ~/.ssh
# WHY: avoid making a duplicate. If id_ed25519.pub exists, skip generation.

# 2. Generate a new SSH key (press Enter through all 3 prompts: default path, no passphrase x2)
ssh-keygen -t ed25519 -C "my-github-email@example.com"
# WHY: creates the keypair the container uses to authenticate to GitHub.

# 3. Print the PUBLIC key and copy the WHOLE line (starts with ssh-ed25519)
cat ~/.ssh/id_ed25519.pub
# WHY: only the .pub (public) key goes to GitHub. Never share the private key (no .pub).
# Added it at: https://github.com/settings/ssh/new  (Title: ubuntu-docker-container)

# 4. Test the connection (type "yes" on first connect)
ssh -T git@github.com
# WHY: confirms GitHub recognizes the key. Looking for "Hi saftab4-arch!".

# 5. Clone the repo over SSH
git clone git@github.com:saftab4-arch/jira-practice.git
cd jira-practice

# 6. Set the git identity INSIDE the container (own git config per machine)
git config --global user.email "my-jira-matched-email@example.com"
git config --global user.name "Syed Basit Aftab"
git config user.email   # verify it prints the matched email
# WHY: smart commits need this email to match a verified Atlassian email.

### Smart commit commands and why

# 1. Created a branch named with the issue key (modern syntax; checkout -b also works)
git switch -c PRAC-2-smart-commit-test
# WHY: the key (PRAC-2) in the branch links code to the ticket.

# 2. COMMENT on the ticket from a commit
echo "smart commit test" >> notes.txt
git add notes.txt
git commit -m "PRAC-2 #comment Testing smart commits from my terminal"
git push -u origin PRAC-2-smart-commit-test
# WHY: "#comment <text>" posts everything after it as a comment on PRAC-2.

# 3. LOG TIME on the ticket
git commit -m "PRAC-2 #time 45m Configured the test setup"
git push
# WHY: "#time 45m" logs 45 min of work (formats: 2h, 45m, 1h 30m). Shows in Work log tab.

# 4. TRANSITION the ticket to Done
git commit -m "PRAC-2 #done Finished testing smart commits"
git push
# WHY: "#done" moves the ticket to the Done status. The keyword must match a real
# transition in the workflow (status is literally named "Done").

# 5. ALL THREE in one commit (how you'd really use it)
git commit -m "PRAC-2 #comment wrapping up #time 30m #done"
git push
# WHY: Jira reads every command in the message — comment + log + close in one shot.

### The three smart commit commands
- #comment <text>   -> adds a comment
- #time <amount>    -> logs work (2h, 45m, 1h 30m)
- #<transition>     -> moves status (e.g. #done, #close)



### Gotchas I hit
-
- SSH: the Docker container is a SEPARATE machine from Windows — needed its own SSH key added to GitHub (kept my Windows key too; GitHub allows multiple).
- Email match is everything. Branch links by KEY; commands need the verified EMAIL match.
- Jira reads the KEY in the commit MESSAGE for commands, not the branch name — so a commit message saying "PRAC-2" lands on PRAC-2 even on a branch named PRAC-3-...
- Smart commits ONLY work from the terminal — the GitHub web UI commits as a bot, so the email won't match and commands won't fire.


### One-line summary for the Friday README / LinkedIn post
>  Drove a Jira ticket from my terminal — commented, logged time, and closed it via smart commits — with the git/Atlassian email match as the key that makes it all work.
