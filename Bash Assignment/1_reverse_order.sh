#!/bin/bash

# if string not entered then exit
if [[ "${#}" -eq '0' ]]
then
	echo "No string entered"
	exit 1
fi

# now take string
IN_STRING="${1}"
OUT_STRING=""
TEMP=""

# now split by whitespace into array
STR_ARRAY=($IN_STRING)

# Now reverse each word
for i in "${STR_ARRAY[@]}"
do
	TEMP=$(echo "${i}" | rev)
	OUT_STRING="${OUT_STRING}${TEMP} "
done

echo "Reversed string is: ${OUT_STRING}"

exit 0
