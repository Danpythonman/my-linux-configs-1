#!/usr/bin/env bash
set -euo pipefail

# Get the location of this script so that we can find the exclude file easily
# (it should be in the same directory as this script file)
SCRIPT_PATH="$(readlink -f "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(dirname $SCRIPT_PATH)"
EXCLUDE_FILE="$SCRIPT_DIR/restic-exclude.txt"
if [[ ! -f "$EXCLUDE_FILE" ]]; then
    echo "ERROR: Exclude file not found at $EXCLUDE_FILE"
    exit 1
fi

# Make sure Bitwarden session is running so that we can get the repository
# password
if [[ -z "${BW_SESSION:-}" ]]; then
    echo "ERROR: Bitwarden CLI not unlocked. Run: bw unlock"
    exit 1
fi

# Define the repositories and password locations for B2 and local
B2_REPO="b2:daniel-pc-backup-b2:restic-repo"
B2_PASSWORD_COMMAND='bash -c '\''bw get item "Restic Backblaze B2 PC Backup" --session "$BW_SESSION" | jq -r ".fields[] | select(.name==\"Repo password\") | .value"'\'''
LOCAL_MOUNT="/media/daniel/ADATA HD650"
LOCAL_REPO_NAME="restic-repo"
LOCAL_REPO="$LOCAL_MOUNT/$LOCAL_REPO_NAME"
LOCAL_PASSWORD_COMMAND='bash -c '\''bw get item "Restic Local ADATA Hard Drive PC Backup" --session "$BW_SESSION" | jq -r ".fields[] | select(.name==\"Repo password\") | .value"'\'''

# Make sure target argument was provided
TARGET="${1:-}"
if [[ -z "$TARGET" ]]; then
    echo "ERROR: Missing target. Use: b2 or local"
    exit 1
fi

# Parse target argument
case "$TARGET" in
    b2)
        # Ensure Backblaze B2 credentials exist
        if [[ -z "${B2_ACCOUNT_ID:-}" || -z "${B2_ACCOUNT_KEY:-}" ]]; then
            echo "ERROR: B2_ACCOUNT_ID or B2_ACCOUNT_KEY not set in environment"
            echo "Export them before running this script."
            exit 1
        fi
        REPO="$B2_REPO"
        export RESTIC_PASSWORD_COMMAND="$B2_PASSWORD_COMMAND"
        ;;
    local)
        # Ensure external drive is mounted
        if [[ ! -d "$LOCAL_MOUNT" ]]; then
            echo "ERROR: Local mount path does not exist: $LOCAL_MOUNT"
            exit 1
        fi
        if ! mountpoint -q "$LOCAL_MOUNT"; then
            echo "ERROR: Not a mount point (drive not mounted?): $LOCAL_MOUNT"
            exit 1
        fi
        REPO="$LOCAL_REPO"
        export RESTIC_PASSWORD_COMMAND="$LOCAL_PASSWORD_COMMAND"
        ;;
    *)
        echo "ERROR: Invalid target '$TARGET'. Use: b2 or local"
        exit 1
        ;;
esac

# Make sure the repository is initialized by getting its snapshots
if ! restic -r "$REPO" snapshots >/dev/null 2>&1; then
    echo "ERROR: unable to get snapshots of repository at '$REPO'"
    exit 1
fi

# These are the paths on my local PC that I want to backup
BACKUP_PATHS=(
    "/home/daniel/Documents"
    "/home/daniel/Pictures"
    "/home/daniel/Videos"
    "/home/daniel/York"
    "/home/daniel/Old Programming"
    "/home/daniel/Programming"
    "/home/daniel/Resume"
)

# Run the backup
restic \
    -r "$REPO" \
    backup \
    "${BACKUP_PATHS[@]}" \
    --exclude-file "$EXCLUDE_FILE"
