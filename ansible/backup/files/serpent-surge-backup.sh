#!/bin/bash

dbbackup db serpent_surge_db 
dbbackup table scores
dbbackup backup_table