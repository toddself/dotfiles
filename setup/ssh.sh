#!/bin/sh
echo "CONFIGURING SSH"
if [ ! -f $HOME/.ssh/authorized_keys ]; then
  curl -o $HOME/.ssh/authorized_keys https://github.com/toddself.keys
fi 
chmod -R 600 $HOME/.ssh/*
chmod -R 600 $HOME/.config/ssh/*
echo "SSH CONFIGURED"
