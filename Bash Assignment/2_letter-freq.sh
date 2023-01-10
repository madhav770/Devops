#!/bin/bash

IN_STRING=$(cat Letter.txt)
FOUND=false

# now split by whitespace into array
STR_ARRAY=($IN_STRING)

# now declare an associative array .. for hashmap
declare -A MAP

# for each word
for i in "${STR_ARRAY[@]}"
do
	FOUND=false					# initially not found
	for key in ${!MAP[@]}
		do
			if [[ $key = $i ]]		# if same word exits, then found
				then
					FOUND=true
			fi
		done
	if $FOUND
		then
			MAP[$i]=$((${MAP[$i]} + 1))		# found, update existing count
		else
			MAP[$i]=1						# new word, add with count 1
	fi
done

# print final result
echo "-----------------------"
echo "Word Frequencies in sorted order"
echo "-----------------------"

for k in "${!MAP[@]}"
do
    echo $k ' - ' ${MAP["$k"]}
done |
sort -rn -k3

exit 0