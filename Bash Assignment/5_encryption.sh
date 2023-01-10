#!/bin/bash

#            SAMPLE USAGE
#
#    ./5_encryption.sh -l 35 -v "abc" -at   # without special character
#    ./5_encryption.sh -l 35 -v "abc" -ats   # with special character
#    ./5_encryption.sh -v "abc" -at   # with default length


# first define global variables
PRINT_ALGO=false
PRINT_TEXT=false
VAL=""
LEN=20
SPECIAL_CHAR=false

# now check getopts for passed parameters
while getopts "atv:sl:" OPTION
do
	case "${OPTION}" in
	a)                      # -a for algo name
	    PRINT_ALGO=true
	;;	
    t)                      # -t for printing plain text
	    PRINT_TEXT=true
	;;
    v)                      # -v: value of text
        VAL="${OPTARG}"
    ;;
    s)                      # -s if a special char is also wanted
       SPECIAL_CHAR=true
    ;;
    l)                      # -l length of generated pswd
        LEN="${OPTARG}"
	esac
done


# list of algos 
ALGOS="sha1sum sha224sum sha256sum sha384sum sha512sum"

# split into array by whitespace
ALGO_ARRAY=($ALGOS)

# Now run for each algo
for i in "${ALGO_ARRAY[@]}"
do
    if $PRINT_ALGO
        then
            echo "Algo name: ${i}"
    fi
    if $PRINT_TEXT
        then
            echo "Text: ${VAL}"
    fi
    HEAD_COMMAND="head -c$LEN"
    TEMP=$(echo "${VAL}" | ${i} | $HEAD_COMMAND)

    if $SPECIAL_CHAR        # special character is also wanted
        then
            CHARS=”\!\@\#\$\%\^\&\*\(\)”            # list of special characters after escaping
            SC=$( echo “$CHARS” | fold -w1 | shuf | head -c1)   # fold in one char lines, then shuffle, and then pick first char
            TEMP="${TEMP}${SC}"                                 # append special character too
        fi
	echo "Password : ${TEMP}"
    echo "=============================="
done

exit