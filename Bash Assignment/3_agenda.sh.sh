#!/bin/bash
TODAY_PATTERN=$(date +%d)
TODAY_MONTH=$(date +%b)
TODAY_PATTERN="${TODAY_PATTERN} ${TODAY_MONTH}"
TOM_PATTERN=$(date +%d -d '+1 day')
TOM_MONTH=$(date +%b -d '+1 day')
TOM_PATTERN="${TOM_PATTERN} ${TODAY_MONTH}"

PICK_NEXT=false
ANS=""
while IFS= read -r line; do

    if $PICK_NEXT
        then
          ANS=$"${ANS};${line}"
    fi

    PICK_NEXT=false
    if [[ "${line}" == "Today"  || "${line}" == "Tomorrow" || "${line}" == "${TODAY_PATTERN}" ||  "${line}" == "${TOM_PATTERN}" ]]
        then
                PICK_NEXT=true
    fi
done < agenda.txt

echo $ANS | tr ';' '\n'