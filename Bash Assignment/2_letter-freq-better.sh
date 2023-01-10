#!/bin/bash

# replace space by new line, then sort alphabetically, then make unique and use awk for printing
cat Letter.txt | tr ' ' '\n' | sort | uniq -c | awk {'print $2 " " $1'}