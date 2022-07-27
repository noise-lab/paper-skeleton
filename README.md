# Paper Skeleton and Editing Process

## Overview

A minimal latex paper skeleton file for writing conference papers. The Makefile requires "rubber", but you can easily change this to build with "pdflatex" instead.

## GitHub

**Overview.** The preferred method for authoring papers in our group is with Github. There are many advantages to doing so, most notably:
* Every edit is version controlled. With pull requests, every edit is reviewed by one other person than the person who made the edit.
* Issues with the project and paper can be tracked with the Github issue tracker and managed via pull requests. Discussions can be easily organized and tracked by issue.
* Issues can be assigned to specific people, who can easily then find their tasks.
* It is useful pedagogically, and it also avoids needless back-and-forth: While someone can simply push edits into master, it is easy to miss edits someone else might be making. Seeing other people's edits can be a useful learning experience, and if you see one of your edits changed or reverted, you can ask why. Maybe people have different style conventions (title case or sentence case? punctuation inside or outside of the quote? let's talk about it...). 
* Slack integration allows collaborators to easily be notified of any changes. (recommended Slack integration: `/github subscribe <repo> issues pulls commits releases deployments comments reviews branches commits:*` 
* It reduces chaos. It might seem "faster" to have everyone simultaneously editing everything in a Google doc or and Overleaf doc. But, the editing process is much less methodical (see above), thus resulting in chaos, an inconsistent end-product, and general stress, since nobody really has a complete view of the paper. The process below ensures that edits are methodical, track issues that collaborators have all discussed and seen, and are reviewed by the group (which is good for cohesion, consensus, and avoiding introduction of errors into the process with hasty editing).
* In the event you are a computer scientist, you should know how to use version control anyway, and doing so with paper editing reinforces good habits. You wouldn't write your code or do your analysis using concurrent editing processes without testing, version, control, and review (I hope!). You should want to learn a methodical process and apply the same approach to all aspects of your project. 

**Editing.** Here is the rough process for editing via Github.
1. Create an issue on Github indicating the nature of your edit (e.g., "reorganize introduction", "align figures", "copy edit pass").
2. On the Github issue, create a branch associated with the issue under "Development".
3. Check out the branch you just created (e.g., locally to your machine via `git fetch; git checkout <branch>`)
4. As you edit, try to make each commit readable by someone else:
  * Make your edits in your local branch.
  * Commit your edits to your local branch. 
  * Push your edits to the upstream branch.
5. When you are done making edits associated with the issue (perhaps multiple commits), create a new pull request on Github from your branch to the main branch.
6. Ask someone (e.g., the primary author) to review and merge your pull request into main. You can do this in several ways: (1) assign a reviewer to your PR; (2) '@' them in Slack, or in a Github comment (or both).
7. Delete the local and remote branch. Whoever merges your PR can delete the branch on Github once it is merged; merging will automatically close the issue, as well. You can delete your local branch with `git branch -d <branch>`.  To avoid warnings, you might want to git checkout main and git pull into main before deleting the local branch.

**Reviewing.** You can review another pull request on the Github website. It can also be handy to have a local copy, because the command line tools are more powerful, and sometimes it may be more efficient to simply commit a small edit to the branch than to ask someone else to make the change.
* The easiest way to review a PR is on the website.  From the PR itself, you can click on any commit and read it.  You can also open a review and/or directly comment on the PR, either though a general comment, or on a specific line.
* If the PR is complicated or if you want to make direct edits and commit them back (instead of commenting), you may want a local copy. You can get one by `git fetch; git checkout <branch>`.  Then you can edit in the branch, commit, and push as normal. Your commits and pushes should track the remote branch on the Github website.
* Diffs can be handy and make for more efficient review. With text, people often word-wrap differently, which makes a standard diff like the one on the website a bit complicated.  Some useful commands for quick review:
  * `git diff -p --word-diff master..<branch>` - will give you a nice redline of the branch you are in against the main branch. (You can compare any two branches this way.)
  * `git whatchanged -p --word-diff` - will give you a "timeline" of the redline, in case you just want to see what was committed in the branch, instead of a diff against main.  You can specify specific files or groups of files with this command, as well (e.g., `*.tex`).

## Overleaf

### First Rule: Don't use it.

Let's first talk about why you should avoid using Overleaf. Why avoid Overleaf? 

* The web-based editor is highly sub-optimal compared to full-featured text editors (which you can customize to your liking), and you're much better off learning to use a real editor on your local machine. Plus, you'll be able to edit offline when you're traveling, when network connectivity fails, or when Overleaf invariably goes offline hours before a deadline.
* The version control is far less good than what git can offer. The ability to get quick redline (e.g., `git whatchanged -p --word-diff`), integrate git commits with Slack and quickly peruse edits, revert changes, avoid gigantic blobs of commented-out latex, etc. is far superior to anything you can do in Overleaf. Spend some time sharpening your paper-writing axe and you'll be able to chop down a lot more trees in the long run.

### Second Rule: If you have to use it, at least sync it with Github.

The second rule is: If you have to use Overleaf (e.g., because you're a glutton for punishment, because a collaborator is unenlightened, etc.), **always sync overleaf to a GitHub repo since many people don't use Overleaf.** People who have sane processes should not have to suffer because you have chosen to use an inferior tool.

Note that there is a copy of this paper skeleton template already [as an Overleaf document](https://www.overleaf.com/read/yvcwdysjjkht). We strongly prefer git to Overleaf, but if you must start with an Overleaf skeleton, at least start with a good one.

#### Option 1: Git Bridge Synchronization 

**This option is preferred if you are a Github user who is trying to collaborate with someone who insists on using overleaf.**

These instructions assume that you have (or create) a Github repository first and want to merge it into an Overleaf project.

1. Create a github repository for your paper as normal.
2. [Import your github repository into Overleaf](https://www.overleaf.com/learn/how-to/Using_Git_and_GitHub#How_do_I_log_in_to_Overleaf_through_Git.3F).
**Note:** Because github now uses "main" instead of "master" for default, and there is no way to change Overleaf's branch name (which is "master"), these instructions are slightly broken. You will have to modify these instructions slightly: In the last step, instead type `git push overleaf main:master`.
3. I recommend creating an "overleaf" branch that you can pull Overleaf edits into separately, and then merging with your local main branch. Example:
  - `git checkout -b overleaf` (create a separate branch for overleaf)
  - `git merge origin main` (merge the main from the remote origin into your local overleaf branch)
  - `git push -u overleaf overleaf:master` (push the local overleaf branch to Overleaf, and have your local `overleaf` branch track edits on Overleaf.)
4. You can set up your main branch to track a Github remote:
  - `git checkout main`
  - `git push -u origin main`

Now you have a local branch `overleaf` that tracks and pushes to Overleaf, and a local branch `main` that you can use as normal.  You can of course do this with a single local branch, but because Overleaf edits are constant, and non-atomic, it's possible and likely that your pull from overleaf at your moment of choosing is unlikely to compile. You may thus find it easier to simply keep the branches separate and occasionally merge in the Overleaf branch, as in the above instructions.

#### Option 2: Github Synchronization

**This option is probably the way to go if you have to collaborate with someone who is using Overleaf as the primary document.**

1. **Create a github repository from Overleaf.**  *Make sure the repo is private* 
2. Once you have a repository sync'd to an Overleaf project, Overleaf's menu->github->push/pull will allow you to use overleaf to push/pull to GitHub.  (Note that you have to manually do this. Before adding new content to your Overleaf document, don't forget to always check if there is new content to pull.
When overleaf pulls changes from GitHub, it automatically does a merge with whatever is in Overleaf. Consequently, merge conflicts can occur. 
I find the simplest way to fix an overleaf/GitHub merge conflict is to just go to the repo in GitHub and use the web interface to fix all the merges (https://docs.github.com/en/free-pro-team@latest/github/collaborating-with-issues-and-pull-requests/resolving-a-merge-conflict-on-github)

3. Make sure your Overleaf document will actually compile with a real Latex compiler. Overleaf handles compile errors differently than other LaTeX compilers. To ensure you have no compile errors you want the "logs and outputs" icon (next to the Green Recompile button) to not be red. Orange is okay. If it is red, non-overleaf people will be unable to compile your work.

4. Once you are done, always push your changes back into the github repository, so that people working from git have your latest edits.

## Style Conventions

To be written.
