#!/usr/bin/env bash
set -euo pipefail

SCRIPT_PATH="$(readlink -f "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(dirname $SCRIPT_PATH)"
EXCLUDE_FILE="$SCRIPT_DIR/restic-exclude.txt"

if [[ ! -f "$EXCLUDE_FILE" ]]; then
    echo "ERROR: Exclude file not found at $EXCLUDE_FILE"
    exit 1
fi

BACKUP_PATHS=(
    "/home/daniel/Documents"
    "/home/daniel/Pictures"
    "/home/daniel/Videos"
    "/home/daniel/York"
    "/home/daniel/Old Programming"
    "/home/daniel/Programming"
    "/home/daniel/Resume"
)

restic \
    -r b2:daniel-backups:restic-repo \
    backup \
    "${BACKUP_PATHS[@]}" \
    --exclude-file "$EXCLUDE_FILE"
