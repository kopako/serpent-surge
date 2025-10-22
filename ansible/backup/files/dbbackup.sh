#!/bin/bash


# /opt/dbbackup/dbbackup.sh
MYSQLCNF_FILE="/opt/dbbackup/my.cnf"
CONFIG_FILE="/opt/dbbackup/.config"
BACKUP_DIR="/backup/dumps"
LOG_DIR="/var/log/dbbackup"
LOG_FILE="$LOG_DIR/dbbackup.log"

mkdir -p "$BACKUP_DIR" "$LOG_DIR"

log() {
    echo "[$(date '+%F %T')] $1" | tee -a "$LOG_FILE"
}

is_config_exists()
    if [[ ! -f "$CONFIG_FILE" ]]; then
        log "Config file not found."
        exit 1
    fi

load_config() {
    is_config_exists
    source "$CONFIG_FILE"
    if [ -z "$DB_NAME" ] || [ -z "$TABLE_NAME" ]; then
        echo "DB_NAME or TABLE_NAME not set in .config"
        exit 1
    fi
}

backup_table() {
    load_config
    local file="$BACKUP_DIR/${DB_NAME}_${TABLE_NAME}_$(date '+%F_%H-%M').sql"
    log "Starting backup: $file"
    mysqldump --defaults-extra-file=$MYSQLCNF_FILE --no-tablespaces  --single-transaction "$DB_NAME" "$TABLE_NAME" > "$file"
    if [[ $? -eq 0 ]]; then
        log "Backup successful: $file"
    else
        log "Backup failed: $file"
        rm -f "$file"
    fi
}

update_config() {
    KEY=$1
    VALUE=$2

    if [ ! -f "$CONFIG_FILE" ]; then
        echo "$KEY=$VALUE" > "$CONFIG_FILE"
    elif grep -q "^$KEY=" "$CONFIG_FILE"; then
        sed -i "s|^$KEY=.*|$KEY=$VALUE|" "$CONFIG_FILE"
    else
        echo "$KEY=$VALUE" >> "$CONFIG_FILE"
    fi
}

case "$1" in
    db)
        if [ -z "$2" ]; then
            echo "Usage: dbbackup db <db_name>"
            exit 1
        fi
        update_config "DB_NAME" "$2"
        echo "Database name set to '$2'"
        ;;

    table)
        if [ -z "$2" ]; then
            echo "Usage: dbbackup table <table_name>"
            exit 1
        fi
        update_config "TABLE_NAME" "$2"
        echo "Table name set to '$2'"
        ;;

    backup_table)
        backup_table
        ;;

    *)
        echo "Usage:"
        echo "  dbbackup db <db_name>"
        echo "  dbbackup table <table_name>"
        echo "  dbbackup backup_table"
        exit 1
        ;;
esac
