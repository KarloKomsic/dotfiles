#!/usr/bin/env bash

DIR="$HOME/Slike/Screenshots"
mkdir -p "$DIR"

FILE="$DIR/screenshot-$(date +'%Y-%m-%d_%H-%M-%S').png"

case "$1" in
  area)
    grim -g "$(slurp)" "$FILE"
    ;;
  *)
    grim "$FILE"
    ;;
esac

notify-send "Screenshot saved" "$FILE"

