#!/bin/sh
DOTFILE_SRC=$PWD
if ! echo $DOTFILE_SRC | grep dotfiles$ > /dev/null; then
  echo "You have to run this from dotfiles root"
  return 1
fi

echo "Starting links from ${DOTFILE_SRC}"

mkdir -p $HOME/bin
mkdir -p $HOME/.config/

setup_dotdirs () {
  DOT_DIRS=$(find $DOTFILE_SRC -type d -name ".*" | grep -v "git")
  echo "SETTING UP DOTDIRS"
  for DOT_DIR in $DOT_DIRS; do
    for CONFIG_FILE in $(find $DOT_DIR -type f); do
      DEST_FILE=$HOME/$(echo $CONFIG_FILE | sed "s|${DOTFILE_SRC}/||")
      DEST_DIR=$(dirname $DEST_FILE)
      SRC_DIR=$(dirname $CONFIG_FILE)
      mkdir -p $DEST_DIR

      if [ "$CONFIG_FILE" = "$SRC_DIR/$HOSTNAME" ]; then
        HOST_SPECIFIC_CONFIG=$DEST_DIR/current-hostname
        if [ -L $HOST_SPECIFIC_CONFIG ]; then
          echo "${HOST_SPECIFIC_CONFIG} already exists!"
        else
          echo "Removing ${HOST_SPECIFIC_CONFIG}"
          rm -f $HOST_SPECIFIC_CONFIG
          echo "Linking ${CONFIG_FILE} to ${HOST_SPECIFIC_CONFIG}"
          ln -s $CONFIG_FILE $HOST_SPECIFIC_CONFIG
        fi
      else
        if [ -L $DEST_FILE ]; then
          echo "${DEST_FILE} already exists!"
        else
          echo "Removing ${DEST_FILE}"
          rm -f $DEST_FILE
          echo "Linking ${CONFIG_FILE} to ${DEST_FILE}"
          ln -s $CONFIG_FILE $DEST_FILE
        fi
      fi
    done
  done
  echo "DONE SETTING UP DOTDIRS"
}

setup_dotfiles () {
  echo "CONFIGURING DOTFILES"
  for DOTFILE in $(find $DOTFILE_SRC -type f -name ".*"); do
    FN=$(basename $DOTFILE) 
    if [ -L $HOME/$FN ]; then
      echo "${HOME}/${FN} exists!"
    else
      echo "Removing ${HOME}/${FN}"
      rm -f $HOME/$FN
      echo "Linking ${DOTFILE} to ${HOME}/${FN}"
      ln -s $DOTFILE $HOME/$FN
    fi
  done
  echo "DOTFILES CONFIGURED"
}

setup_dotfiles
setup_dotdirs
