#!/bin/bash

read -p "Enter Table Name: " tbname

script_dir="DBMS"

table_dir="$HOME/$script_dir/db_dir/$1"
table_file="$table_dir/records_${tbname}.txt"
table_tp="$table_file"

if [[ -z "$tbname" || "$tbname" =~ [/.:\\-] ]]; then
    echo "Error: Table name cannot be empty or have special characters. Please enter a valid name."
elif [[ ! -f "$table_file" ]]; then
    echo "Error: Table $tbname does not exist."
else
    read -p "Enter the primary key value to delete the corresponding record: " primary_key_value

    if [[ -z "$primary_key_value" ]]; then
        echo "Error: Primary key value cannot be empty."
    else
    if grep -q "^$primary_key_value:" "$table_file"; then

        sed -i "/^$primary_key_value:/d" "$table_dir/records_${tbname}.txt"
        echo "Record with primary key $primary_key_value deleted successfully from $tbname table."
    else
        echo "Error: Record with primary key $primary_key_value not found in $tbname table."
    fi

    fi
fi
