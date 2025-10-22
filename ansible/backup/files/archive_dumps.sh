#!/bin/bash

BACKUP_DIR="/backup/dumps"
ARCHIVE_DIR="/backup/backups"
LOG_DIR="/var/log/dbbackup"
LOG_FILE="$LOG_DIR/dbbackup-archive.log"

mkdir -p $ARCHIVE_DIR

log() {
    echo "[$(date '+%F %T')] $1" | tee -a "$LOG_FILE"
}

archive_backups() {
    local timestamp=$(date '+%F_%H-%M')
    local archive_file="$ARCHIVE_DIR/${timestamp}_backup.tar.gz"
    if [ -d "$BACKUP_DIR" ] && [ "$(ls -A "$BACKUP_DIR")" ]; then
        echo "Directory is not empty"
        tar -cvzf "$archive_file" -C "$BACKUP_DIR" .
        tar_status=$?
    else
        echo "Directory $BACKUP_DIR is empty or does not exist"
        tar_status=1
    fi

    if [[ $tar_status -eq 0 ]]; then
        cd $ARCHIVE_DIR
        log "Archive created: $archive_file"
        find "$BACKUP_DIR" -type f -name '*.sql' -delete
        prune_archives
    else
        log "Archive failed: $archive_file"
    fi
}

prune_archives() {
    tars=($(ls -t "$ARCHIVE_DIR"/*.tar.gz))
    if [[ ${#tars[@]} -lt 3 ]]; then
        log "There are less then three archive, doing nothing"
    else
        log "Start removing old archives"
        end=$(( ${#tars[@]} - 1 ))
        for i in $(seq 3 ${end}); do
            rm "${tars[$i]}" && log "Removed '${tars[$i]}'" || echo "Cannot remove: '${tars[$i]}'"
        done
    fi
}

list_archives() {
    echo "date;size"
    for file in "$ARCHIVE_DIR"/*.tar.gz; do
        [[ -f "$file" ]] || continue
        echo "$(basename "$file" | cut -d'_' -f1 | tr '-' '.')"; stat -c "%s" "$file"
    done | paste - - | awk '{printf "%s;%s\n", $1, $2}'
}

case "$1" in
    --help)
        echo "Usage:"
        echo "  Run without parameters to archivate sql dumps"
        echo "  $0 list_archives"
        ;;
    list_archives)
        list_archives
        ;;
    *)
        archive_backups
        ;;
esac
