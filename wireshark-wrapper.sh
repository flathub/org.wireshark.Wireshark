#!/bin/bash

set -euo pipefail

if [[ "${SKIP_WARNING:-0}" != "1" ]]; then
  STATE_DIR="${XDG_CACHE_HOME}/wireshark-flathub"
  STATE_FILE="$STATE_DIR/warning_shown"

  if [[ ! -f "$STATE_FILE" ]]; then
    if zenity --question \
      --title="Warning" \
      --width=500 \
      --height=100 \
      --ok-label="Run Wireshark" \
      --cancel-label="Exit" \
      --text="This Wireshark package does not support capturing data.\n\nPress \"Exit\" to close, \"Run Wireshark\" to continue"; then
      mkdir -p "$STATE_DIR" && touch "$STATE_FILE"
    else
      echo "Exiting."
      exit 0
    fi
  fi
fi

exec wireshark "$@"
