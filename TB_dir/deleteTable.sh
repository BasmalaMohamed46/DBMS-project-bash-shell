#!/bin/bash

read -p "Enter Table Name: " tbname

script_dir="DBMS"
table_dir="$HOME/$script_dir/db_dir/$1"
records_file="$table_dir/records_${tbname}.txt"

if [[ -z "$tbname" || "$tbname" =~ [/.:\\-] ]]; then
    echo "Error: Table name cannot be empty or have special characters. Please enter a valid name."
elif [[ ! -f "$records_file" ]]; then
    echo "Error: Table $tbname does not exist."
else
    read -p "Enter the primary key value to identify the record: " primary_key_value

    if [[ -z "$primary_key_value" ]]; then
        echo "Error: Primary key value cannot be empty."
    else
        if grep -Eq ":$primary_key_value:" "$records_file"; then
            sed -i "/:$primary_key_value:/d" "$records_file"
            echo "Record with primary key $primary_key_value deleted successfully from $tbname table."
        else
            echo "Error: Record with primary key $primary_key_value not found in $tbname table."
        fi
    fi
fi
