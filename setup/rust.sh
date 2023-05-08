#!/bin/sh

CARGO_PACKAGES="git-delta zoxide fd-find bottom bat exa ripgrep starship stylua taplo-cli"
for PKG in $CARGO_PACKAGES; do
  cargo install $PKG
done

asdf reshim rust
