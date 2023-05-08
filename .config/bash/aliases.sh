#aliases
alias gs="git status"
alias gd="git diff"
alias gl="git lg"
alias rmnm="rm -rf node_modules/ && npm install"
alias clip="nc -U ~/.clipper.sock"
alias ghpr="gh pr create -F .github/pull_request_template.md --title \"\$($GIT commit-title)\" --body \"\$($GIT commit-body)\" --fill"
