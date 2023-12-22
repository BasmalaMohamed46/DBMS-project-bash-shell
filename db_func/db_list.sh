#!/bin/bash
script_dir="DBMS"
directory="$HOME/$script_dir/db_dir"
flag=0

if [ -z "$(ls -l "$directory" | grep '^d')" ]
then
    echo "There is no database" 
else
    flag=1
    echo "Available DataBases: "
    ls -l "$directory" | grep '^d' | awk '{print $NF}'
fi 
export x
