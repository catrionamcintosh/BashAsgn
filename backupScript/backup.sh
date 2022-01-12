#!/bin/bash
if [[ -z "$2" ]]
then
	echo "Error: Expected two input parameters"
	echo "Usage: ./backup <backupdirctory> <fileordirtobackup>"
	exit 1
elif [[ ! -f "$2" ]] && [[ ! -d "$2" ]]
then
	echo "Error: File or directory to backup does not exist"
	echo "Usage: ./backup.sh <backupdirectory> <fileordirtobackup>"
	exit 2
elif [[ ! -d "$1" ]]
then
	echo "Error: The directory '"$1"' does not exist"
	echo "Usage: ./backup.sh <backupdirectory> <fileordirtobackup>"
	exit 2
elif [[ "$1" = "$2" ]]
then 
	echo "Error: Destination and backup file are the same"
	echo "Usage: ./backup.sh <backupdirectory> <fileordirtobackup>"
	exit 2
fi

b=$(basename $2)
x="$1/$b-$(date '+%Y%m%d').tar"
if [[ -f "$x" ]]
then
	echo "Backup file '"$x"' already exists. Overwrite? (y/n)"
	read response
	if [[ "$response" = "n" ]]
	then
		exit 3
	fi
fi
tar -cvf $x $2 > /dev/null 2>&1
exit 0

