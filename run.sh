#!/usr/bin/env bash

DEVICE=$1

if [[ -z $DEVICE ]]; then
  echo "Device is not set. Possible values: laptop|desktop"
  exit 1
fi

if [[ $DEVICE == "laptop" ]]; then
  cp ./etc/X11/xorg.conf.d/{15-trackpoint.conf,16-disable-touchpad.conf} /etc/X11/xorg.conf.d/
elif [[ $DEVICE == "desktop" ]]; then
  cp ./etc/modprobe.d/blacklist-nouveau.conf /etc/modprobe.d/blacklist-nouveau.conf
else
  echo "laptop|desktop"
  exit 1
fi

# network config
cp ./etc/systemd/network/20-wired.network /etc/systemd/network/20-wired.network

# 
cp ./.vimrc     $HOME/
cp ./.tmux.conf $HOME/

cp ./etc/default/keyboard /etc/default/keyboard

