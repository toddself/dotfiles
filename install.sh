#!/usr/bin/env bash

DOTFILE_SRC=$(dirname "${BASH_SOURCE[0]}")
if [ "$DOTFILE_SRC" = "." ]; then
  DOTFILE_SRC=$PWD
fi

OS_NAME=$(uname -s | tr A-Z a-z)
ARCH=$(uname -m)
if command -v lsb_release >> /dev/null; then
  DISTRO=$(lsb_release -is | tr A-Z a-z)
else
  echo "Missing lsb_release tool"
  if [ "$OS_NAME" = "linux" ]; then
    exit 1
  fi
  DISTRO=""
fi

if [ -f /etc/hostname ]; then
  HOSTNAME=$(cat /etc/hostname)
elif command -v hostnamectl >> /dev/null; then
  HOSTNAME=$(hostnamectl hostname)
else
  HOSTNAME=$(hostname)
fi

echo "Script source: ${DOTFILE_SRC}, OS: ${OS_NAME}, ARCH: ${ARCH}, DISTRO: ${DISTRO}"

bash setup/create-links.sh
bash setup/asdf.sh
bash setup/fzf.sh
if [ -f ${DOTFILE_SRC}/setup/${OS_NAME}/${DISTRO}/install.sh ]; then
  bash ${DOTFILE_SRC}/setup/${OS_NAME}/${DISTRO}/install.sh
fi
bash setup/nvim.sh
bash setup/vim.sh
bash setup/ssh.sh
bash setup/git.sh
bash setup/rust.sh
