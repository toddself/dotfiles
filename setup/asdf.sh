#!/bin/sh
echo "-> Installing asdf"

DOTFILE_SRC=$(dirname "${BASH_SOURCE[0]}")
if [ "$DOTFILE_SRC" = "." ]; then
  DOTFILE_SRC=$PWD
fi

. $DOTFILE_SRC/../VERSIONS

if [ -d ${HOME}/.asdf ]; then
  cd ${HOME}/.asdf
  git fetch origin && git checkout "v${ASDF_VERSION}" > /dev/null
else
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch "v${ASDF_VERSION}" > /dev/null
fi
. $HOME/.asdf/asdf.sh

# setup python
echo "-> Installing Python ${PYTHON_VERSION}"
asdf plugin add python > /dev/null
asdf install python $PYTHON_VERSION > /dev/null
asdf global python $PYTHON_VERSION > /dev/null

echo "-> Installing Node ${NODE_VERSION}"
asdf plugin add nodejs > /dev/null
asdf install nodejs $NODE_VERSION > /dev/null
asdf global nodejs $NODE_VERSION > /dev/null

echo "-> Installing Rust ${RUST_VERSION}"
asdf plugin add rust > /dev/null
asdf install rust ${RUST_VERSION}
asdf global rust ${RUST_VERSION}

echo "-> Installing Go ${GO_VERSION}"
asdf plugin add golang
asdf install golang ${GO_VERSION}
asdf global golang ${GO_VERSION}

echo "-> asdf installed and configured"

