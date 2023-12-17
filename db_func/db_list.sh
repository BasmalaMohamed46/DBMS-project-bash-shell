#!/bin/bash
directory="$HOME/db_dir"
flag=0
if [ -z "$(ls -l "$directory" | grep '^d')" ]
then
echo "There is no database" 
flag=1
else
echo "Available DataBases: "
ls -l "$directory" | grep '^d' | awk '{print $NF}'
fi 
export x
