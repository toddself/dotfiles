#!/bin/sh -xe
echo "-> Configuring vim"
mkdir -p $HOME/.config/coc/extensions
cd $HOME/.config/coc/extensions

if [ ! -f package.json ]; then
  echo '{"dependencies":{}}' > package.json
  if command -v npm >> /dev/null; then
    npm install coc-deno coc-yaml coc-go coc-tsserver coc-rust-analyzer coc-json --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod
  fi
fi

curl -fLo ${HOME}/.vim/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim -es -u ${HOME}/.vimrc -i NONE -c "PlugInstall" -c "qa"
echo "-> Configured vim"
