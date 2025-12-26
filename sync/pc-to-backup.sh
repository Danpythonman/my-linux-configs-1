#!/usr/bin/env bash
set -euo pipefail

rsync_exclude_file='rsync-exclude.txt'

usage() {
    echo 'Usage: pc-to-backup.sh <folder-name> [--dry-run]'
}

if [[ "${1:-}" == '--help' ]]; then
    usage
    exit 0
fi

if [[ $# -lt 1 || $# -gt 2 ]]; then
    usage
    exit 1
fi

folder="$1"
if [[ -z "$folder" ]]; then
    echo 'Folder name cannot be empty'
    usage
    exit 1
fi

if [[ ! "$folder" =~ ^[A-Za-z0-9_-]+$ ]]; then
    echo "Invalid folder name '$folder'."
    exit 1
fi

if [[ ! -f "$rsync_exclude_file" ]]; then
    echo "Exclude file not found: $rsync_exclude_file"
    exit 1
fi

rsync_args=(-av --info=progress2 --exclude-from="$rsync_exclude_file")
if [[ ${2:-} == '--dry-run' ]]; then
    rsync_args+=('--dry-run')
fi

destination="/media/daniel/ADATA HD650/$folder/"

rsync \
    "${rsync_args[@]}" \
    '/home/daniel/Documents' \
    '/home/daniel/Pictures' \
    '/home/daniel/Videos' \
    '/home/daniel/York' \
    '/home/daniel/Old Programming' \
    '/home/daniel/Programming' \
    '/home/daniel/Resume' \
    "$destination"

