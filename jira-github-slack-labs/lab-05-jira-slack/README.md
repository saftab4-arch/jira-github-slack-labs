# Lab 5 — Jira <-> Slack: ticket activity in a channel

> **Day:** Wednesday

## Goal
Wire Jira to Slack so issue activity is visible, and create issues from Slack.

**Integration taught:** Jira -> Slack notifications + Slack -> Jira creation.

## Steps
1. Create a free Slack workspace + channel `#portfolio-jira`.
2. Install the **Jira Cloud for Slack** app from Slack's app directory.
3. Connect to your Jira site; subscribe `#portfolio-jira` to events (issue created, transitioned).
4. Move an issue in Jira -> watch it post to Slack.
5. From Slack type `/jira create` and make a ticket without leaving Slack.

**Done when:** A Jira transition shows in `#portfolio-jira`, and you've created one issue from Slack.

> **Gotcha:** Subscribe to only the events you care about, or the channel turns into noise. Start minimal.

---

## My work log (fill this in as you go)

### What I did

Created a free Slack workspace portfolio-jira (I am the admin — required to install apps).
Created a dedicated #jira channel for Jira events (kept separate from #all-portfolio-jira to isolate the noise).
Installed the official Jira Cloud app by Atlassian from the Slack app directory.
Linked my user identity to Atlassian, then ran /jira connect and connected the PORTFOLIO (POR) project on basitusa2020.atlassian.net to #jira.
Tuned the notification events down to a clean signal (created + transitioned only).
Proved both directions: created POR-9 in Jira (posted to Slack), created POR-10 via /jira create from Slack (appeared on the POR board), and dragged tickets across columns to fire transition notifications.
- 

### Commands / config that actually worked
```
# In the #jira channel:
/jira connect          # subscribe the channel to a Jira project's event stream
                       # -> selected PORTFOLIO (POR), channel #jira

/jira create           # opens a modal to create an issue from Slack
                       # -> Project: POR, Type: Task, Summary: "Created from Slack — test"
Notification config (Manage -> Channel notifications for POR):
Issue is:                 created          # dropped "updated" and "deleted" (noise)
Status is transitioned to: To Do, In Progress, Done   # explicit list — empty did NOT fire
For issues that match:    Type: All, Priority: All
Notification style:       Truncated        # clean one-liner with status/type/priority badges
```


### Gotchas I hit

Two separate authorizations. Installing the app is a workspace-level (admin) action. Running /jira connect needs a separate user-level Atlassian login. The first /jira connect failed with "please authorize Slack & login" until I clicked the in-message Log In button and completed OAuth in the browser. Logging into Atlassian in another tab does not complete this.
Empty "Status is transitioned to" = no transition notifications. Leaving it blank fired nothing on transitions; this app version treats empty as "don't track." Fix: explicitly list To Do, In Progress, Done, then Save. Transitions fired immediately after.
Dropped updated/deleted from the "Issue is" field — updated fires on every minor edit and floods the channel.
- 

### One-line summary for the Friday README / LinkedIn post
Connected Jira (POR) to Slack #jira for true two-way integration — issue-created and status-transition events post to Slack, and /jira create files tickets from Slack straight onto the board.
