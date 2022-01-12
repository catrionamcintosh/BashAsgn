#!/bin/bash
if [[ -z "$1" ]]
then
	echo "Error: No log file given"
	echo "Usage: ./webmetrics.sh <logfile>"
	exit 1
fi
if [[ ! -f "$1" ]]
then
	echo "Error: File '"$1"' does not exist."
	echo "Usage: ./webmetrics.sh <logfile>"
	exit 2
fi
echo "Number of requests per web browser"
requestSafari="$(grep -ci "safari" $1)"
echo "Safari, $requestSafari"
requestFireFox="$(grep -ci "firefox" $1)"
echo "Firefox, $requestFireFox"
requestChrome="$(grep -ci "chrome" $1)"
echo "Chrome, $requestChrome"
echo

echo "Number of distinct users per day"
x=$(awk -F [ '/[0123][0-9][/][JFMASOND][aepuco][nbrynlgptvc][/][012][0-9][0-9][0-9]/{ print $2 }' < $1 | awk -F : '{ print $1 }' | sort -u)
for i in $x
do
	users=0
	y=$(grep $i $1 | awk '{ print $1 }' | sort -u)
	for j in $y
	do
		users=$((users+1))
	done
	
	echo "$i, $users"
done
echo
echo "Top 20 popular product requests"
awk -F / '/GET [/]product[/][0-9]*[/]/{ print $5 }' < $1 | sort -rn | uniq -c | sort -rn | head -20 | awk '{ print $2,",",$1 }'
echo
exit 0
