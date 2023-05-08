#!/bin/sh
echo "-> Configuring nvim"
OS_NAME=$(uname -s | tr A-Z a-z)
DOTFILE_SRC=$(dirname "${BASH_SOURCE[0]}")
if [ "$DOTFILE_SRC" = "." ]; then
  DOTFILE_SRC=$PWD
fi

. $DOTFILE_SRC/../VERSIONS

if [ ! -f $HOME/bin/nvim-${NEOVIM_VERISON} ] && [ "$OS_NAME" = "linux" ]; then
  echo "-> Installing neovim appimage ${NEOVIM_VERSION}"
  # Install neovim
  mkdir -p $HOME/bin
  curl -L -o $HOME/bin/nvim-${NEOVIM_VERSION} https://github.com/neovim/neovim/releases/download/v${NEOVIM_VERSION}/nvim.appimage
  chmod a+x $HOME/bin/nvim-${NEOVIM_VERSION}
  rm $HOME/bin/nvim
  ln -s $HOME/bin/nvim-${NEOVIM_VERSION} $HOME/bin/nvim
fi

if command -v python3 > /dev/null; then
  python3 -m pip install --user --upgrade pynvim
fi

if command -v node > /dev/null; then
  npm -g install neovim
fi

$HOME/bin/nvim --headless -c 'autocmd User PackerCompile quitall' -c 'PackerSync' -c 'quitall'
echo "-> nvim configured"
