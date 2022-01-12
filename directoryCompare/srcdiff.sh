#!/bin/bash
status=0
if [[ -z "$2" ]]
then
        echo "Error: Expected two input parameters"
        echo "Usage: ./srcdiff.sh <oridinaldirctory> <comparisondirectory>"
        exit 1
elif [[ ! -d "$1" ]]
then
	echo "Error: Input parameter #1 '"$1"' is not a directory"
        echo "Usage: ./srcdiff.sh <oridinaldirctory> <comparisondirectory>"
	exit 2
elif [[ ! -d "$2" ]]
then
	echo "Error: Input parameter #2 '"$2"' is not a directory"
	echo "Usage: ./srcdiff.sh <oridinaldirctory> <comparisondirectory>"
	exit 2
elif [[ "$1" = "$2" ]]
then
	echo "Input directories are the same"       
       	echo "Usage: ./srcdiff.sh <oridinaldirctory> <comparisondirectory>"
	exit 2
fi
for f in $(ls "$1")
do
	freal="$1/$f"
	if [[ -f "$freal" ]]
	then
		c=""
		for f2 in $(ls "$2")
		do
			f2real="$2/$f2"
			if [[ "$f" = "$f2" ]]
			then
				c="same"
				x=$(diff "$freal" "$f2real")
				if [[ $x != "" ]]
				then 
					echo ""$freal" differs"
					status=3
				fi
			fi
		done
		if [[ "$c" = "" ]]
		then 
			echo "$freal is missing"
			status=3
		fi
	fi
done
for f in $(ls "$2")
do
	freal="$2/$f"
	if [[ -f "$freal" ]]
	then
		c=""
		for f1 in $(ls $1)
		do
			if [[ "$f" = "$f1" ]]
			then
				c="same"
			fi
		done
		if [[ "$c" = "" ]]
		then
			echo "$freal is missing"
			status=3
		fi
	fi
done
exit $status
