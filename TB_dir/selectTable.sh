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
          col_line_number=$(grep -n "^$column_to_select:" "$table_file" | cut -d: -f1)
    
          if [[ -n "$col_line_number" ]]; then
          awk -F: -v col_line_number="$col_line_number" '{print $col_line_number}' "$records_file"
         else
        echo "Error: Column $column_to_select not found in the table file."
        fi
        ;;
        3)
            # Select by Primary Key
            read -p "Enter primary key value: " primary_key_value
            grep "$primary_key_value:" "$records_file"
            ;;
        *)
            echo "Invalid operation. Please select a valid option."
            ;;
    esac
fi
