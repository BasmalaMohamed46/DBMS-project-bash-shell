#!/bin/bash
script_dir="DBMS"
directory="$HOME/$script_dir/db_dir/$1"
flag=0

if [ -z "$(ls "$directory")" ]
then
    echo "There are no tables."
else
    flag=1
    echo "Tables of the database $1:"
    ls "$directory" | grep -v '^records'
fi

export flag
