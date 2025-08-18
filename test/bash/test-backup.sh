#!/usr/bin/env bash

RSYNC_BASE="echo rsync"

RSYNC_OPTIONS=(-tzvrPc --delete)
LOG_FILE="/mnt/ramdisk/backup.log"

BACKUP_TARGET="backup:/test"

source scripts/bash/backup.sh

if [ -n "${LOG_FILE}" ]; then
  echo > "${LOG_FILE}"
fi

#set -x

backup "/home/" "${BACKUP_TARGET}/home/"

# Back up `~/.local'
# Excludes distrobox container files
RSYNC_OPTIONS=(-tzvrPc -e 'ssh -J fwd' --delete --exclude='share/containers')

backup "/etc/" "${BACKUP_TARGET}/etc/"
