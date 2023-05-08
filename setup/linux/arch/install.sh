#!/bin/sh
echo "-> Installing packages from arch"
sudo pacman -Sy --needed $(comm -12 <(pacman -Slq|sort) <(sort pkglist.txt)) > /dev/null

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

echo "-> Installing packages from AUR"
pacaur -S --noedit --noconfirm --needed $(cat aur-pkglist.txt) > /dev/null

