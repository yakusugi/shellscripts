#!/bin/bash

#set backup params
backup_dir="/shares/smb/seagate_hdd_5tb/sample_backup"
backup_file="backup_$(date +%Y%m%d).tar.gz"
remote_server="192.168.0.104"
remote_dir="/path/to/dir"

# Create backup archive
tar -czvf "$backup_dir/$backup_file" /shares/smb/seagate_hdd_5tb/Kotlin/excel_tutorials/Kotlin_Android_Room_NoteApp.xlsx

# Transfer backup to remote server
rsync -avz "$backup_dir/$backup_file" "$remote_server:$remote_dir"
