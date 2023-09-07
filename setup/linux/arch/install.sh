#!/bin/sh
if [ ! -d ${HOME}/.pacaur ]; then
  echo "-> Installing pacaur"
  mkdir $HOME/.pacaur 
  pushd $HOME/.pacaur
  git clone https://aur.archlinux.org/auracle-git.git > /dev/null
  pushd $HOME/.pacaur/auracle-git
  makepkg -sic > /dev/null
  popd
  git clone https://aur.archlinux.org/pacaur.git > /dev/null
  pushd $HOME/.pacaur/pacaur
  makepkg -sic > /dev/null
  popd
  popd
fi
