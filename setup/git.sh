set +x
# configure git diff command
GIT=$(which git)
ME=$(whoami)
echo "git is ${GIT}, you are ${ME}"

if [ ! -f ${HOME}/.gitconfig ]; then
  # user data
  $GIT config --global user.name "Todd Kennedy"
  [ -f ${HOME}/.gpg-key] && $GIT config --global user.signingKey $(cat ${HOME}/.gpg-key)

  if [ "$ME" = "tkennedy1" ]; then
    $GIT config --global user.email "95242064+tkennedy1-godaddy@users.noreply.github.com"
    $GIT config --global github.user tkennedy1-godaddy
  else
    $GIT config --global user.email "193412+toddself@users.noreply.github.com"
    $GIT config --global github.user toddself
  fi

  #defaults
  $GIT config --global difftool.prompt false
  $GIT config --global mergetool.prompt false
  $GIT config --global pull.rebase true
  $GIT config --global init.defaultBranch main
  $GIT config --global tag.sort -version:refname

  # diff data
  $GIT config --global core.excludesFile "${HOME}/.gitignore"
  if command -v delta >> /dev/null; then
    $GIT config --global core.pager "delta --dark"
    $GIT config --global interactive.diffFilter "delta --color-only"
    $GIT config --global add.interteractive.useBuiltin false
  fi

  # npm merge driver
  if command -v npm-merge-driver > /dev/null; then
    $GIT config --global merge."npm-merge-driver".driver "npx npm-merge-driver merge %A %O %B %P"
  fi

  # install nice gitlog if it's not there...
  if [ -z "$($GIT config --global alias.lg)" ]; then
      $GIT config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
  fi

  # get a way to get the title of the last commit
  if [ -z "$($GIT config --global alias.commit-title)" ]; then
    $GIT config --global alias.commit-title "log --pretty=format:\"%s\" -n 1"
  fi

  # get a way to get the body of the last commit
  if [ -z "$($GIT config --global alias.commit-body)" ]; then
    $GIT config --global alias.commit-body "log --pretty=format:\"%b\" -n 1"
  fi

  # add shorthand for checkout
  if [ -z "$($GIT config --global alias.co)" ]; then
    $GIT config --global alias.co "checkout"
  fi
fi

