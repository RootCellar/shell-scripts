#!/usr/bin/env bash

# Inputs:
# RSYNC_BASE (optional)
# LOG_FILE
# RSYNC_OPTIONS

RSYNC_BASE=${RSYNC_BASE:-"rsync"}

source scripts/bash/date.sh

function log() {
  echo "$*" >> "${LOG_FILE}"
}

function backup() {
  if [ -z "${LOG_FILE}" ]; then
    echo "Refusing to run with no LOG_FILE given."
    return 1
  fi

  if [ -z "${RSYNC_OPTIONS}" ]; then
    echo "Refusing to run with no RSYNC_OPTIONS given."
    return 1
  fi

  log Backing up '"'"$1"'"' to '"'"$2"'"'...

  command_to_run="${RSYNC_BASE} ${RSYNC_OPTIONS[@]} $@"

  log
  log "Command: ${command_to_run} "
  log "Sync Begin: $(date_and_time) "
  log

  ${command_to_run} >> "${LOG_FILE}" 2>&1 || {
    echo "Error encountered during backup. See ${LOG_FILE}"
    return 1
  }
  log
  log "Sync End: $(date_and_time) "
  return 0
}
