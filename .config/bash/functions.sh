if ! type gp 1>/dev/null 2>&1; then
  # add function to push current branch to origin
  function gp () {
      $GIT push -u origin $(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p') $@
  }
fi

if command -v fzf > /dev/null; then
  # use fzf to delete branches nicely
  function delete-branches() {
    XARGS_BIN=xargs
    if command -v gxargs > /dev/null; then
      XARGS_BIN=gxargs
    fi
    git branch |
      grep --invert-match '\*' |
      cut -c 3- |
      fzf --multi --preview="git log {}" |
      $XARGS_BIN --no-run-if-empty git branch --delete --force
  }
fi
