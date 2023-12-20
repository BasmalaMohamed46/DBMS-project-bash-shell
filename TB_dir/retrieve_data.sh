#!/bin/bash

read -p "Enter Table Name: " tbname

table_dir="$HOME/db_dir/$1"
table_file="$table_dir/$tbname"

if [[ -z "$tbname" || "$tbname" =~ [/.:\\-] ]] \
then
    echo "Error: Table name cannot be empty or have special characters. Please enter a valid name."
elif [[ ! -f "$table_file" ]]
then
    echo "Error: Table $tbname does not exist."
else
    columns=($(cut -d: -f1 "$table_file"))
    datatypes=($(cut -d: -f2 "$table_file"))

    for col in "${columns[@]}"
    do
        echo -n "$col | "
    done
    echo ""

    for col in "${columns[@]}"
    do
        echo -n "--------+"
    done
    echo ""


    awk -F: -v OFS=" | " '{ print $1, $2, $3 }' "$table_dir/records.txt"
fi
