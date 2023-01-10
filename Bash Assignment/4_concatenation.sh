#!/bin/bash

IN_STR=$1
STR_LEN=${#IN_STR}
WORDS=$2
WORDS=(${WORDS//,/ })
WLEN=${#WORDS[0]} 
WARR_LEN=${#WORDS[@]} 

substr_size=$(($WLEN * $WARR_LEN))

if [[ "$STR_LEN" -lt "$substr_size" ]]
then
   echo "string size small!!"
   exit 1
fi

bar=$(IFS=, ; echo "${WORDS[*]}")
evalStr=''
for (( i=0 ; i < $WARR_LEN ; i++ ))
do
evalStr=$evalStr{${bar[@]}}
done

combination=$(eval echo ${evalStr[@]})

perm_array=()
echo "Please wait"
regex_exp='\b\w*(\w{'$WLEN'})\w*\1'

for el in $combination
do
(echo $el | grep -Eq  '\b\w*(\w{2})\w*\1') && discard=true || discard=false

if [ "$discard" = false ]
   then
      perm_array+=($el)
   fi

echo -ne "."
done

result=()
for (( s=0 ; s<$STR_LEN ; s++ ))
do
if [[ $(($STR_LEN - $s)) -lt $substr_size ]]
then
   break;
fi
substr=${str:$s:$substr_size}
if [[ " ${perm_array[*]} " =~ " ${substr} " ]]; 
then
   result+=($s)

fi
done

echo -e "\n Result Indices:" ${result[@]}