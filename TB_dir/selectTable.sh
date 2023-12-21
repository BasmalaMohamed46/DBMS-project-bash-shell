#!/bin/bash

read -p "Enter Table Name: " tbname

table_dir="$HOME/db_dir/$1"
table_file="$table_dir/$tbname"
records_file="$table_dir/records.txt"

if [[ -z "$tbname" || "$tbname" =~ [/.:\\-] ]]; then
    echo "Error: Table name cannot be empty or have special characters. Please enter a valid name."
elif [[ ! -f "$table_file" ]]; then
    echo "Error: Table $tbname does not exist."
else
    read -p "Select operation: (1) Select All, (2) Select Single Column, (3) Select by Primary Key: " operation

    case $operation in
        1)
            # Select All
            cat "$records_file"
            ;;
        2)
            # Select Single Column
            read -p "Enter column to select: " column_to_select
            col_metadata=$(grep "^$column_to_select:" "$table_file")
            if [[ -n "$col_metadata" ]]; then
                cut -d: -f1 "$records_file" | while read -r record; do
                    echo "$record" | awk -F: "{print \$$((i + 1))}" i=$(echo "$col_metadata" | grep -o ":" | wc -l) OFS=":"
                done
            else
                echo "Error: Column $column_to_select not found."
            fi
            ;;
        3)
            # Select by Primary Key
            read -p "Enter primary key value: " primary_key_value
            grep "^$primary_key_value:" "$records_file"
            ;;
        *)
            echo "Invalid operation. Please select a valid option."
            ;;
    esac
fi
