# paper-skeleton

## Overview

A minimal latex paper skeleton file for writing conference papers. The Makefile requires "rubber", but you can easily change this to build with "pdflatex" instead.

## Style Conventions

To be written.

## Overleaf

**Always sync overleaf to a GitHub repo in noise-lab since many people don't use Overleaf.**

Note that there is a copy of this paper skeleton template already [as an Overleaf document](https://www.overleaf.com/read/yvcwdysjjkht). We strongly prefer git to Overleaf, but if you must start with an Overleaf skeleton, at least start with a good one.

### Syncing Between Overleaf to Github

1. **Create a github repository from Overleaf that is in the noise-lab organization.**  *Make sure the repo is private* 
2. Once you have a repository sync'd to an Overleaf project, Overleaf's menu->github->push/pull will allow you to use overleaf to push/pull to GitHub.  (Note that you have to manually do this. Before adding new content to your Overleaf document, don't forget to always check if there is new content to pull.
When overleaf pulls changes from GitHub, it automatically does a merge with whatever is in Overleaf. Consequently, merge conflicts can occur. 
I find the simplest way to fix an overleaf/GitHub merge conflict is to just go to the repo in GitHub and use the web interface to fix all the merges (https://docs.github.com/en/free-pro-team@latest/github/collaborating-with-issues-and-pull-requests/resolving-a-merge-conflict-on-github)

3. Make sure your Overleaf document will actually compile with a real Latex compiler. Overleaf handles compile errors differently than other LaTeX compilers. To ensure you have no compile errors you want the "logs and outputs" icon (next to the Green Recompile button) to not be red. Orange is okay. If it is red, non-overleaf people will be unable to compile your work.

4. Once you are done, always push your changes back into the github repository, so that people working from git have your latest edits.
