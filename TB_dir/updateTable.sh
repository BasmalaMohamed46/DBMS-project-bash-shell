#!/bin/bash

read -p "Enter Table Name: " tbname
script_dir="DBMS"
table_dir="$HOME/$script_dir/db_dir/$1"
table_file="$table_dir/$tbname"
records_file="$table_dir/records_${tbname}.txt"

if [[ -z "$tbname" || "$tbname" =~ [/.:\\-] ]]; then
    echo "Error: Table name cannot be empty or have special characters. Please enter a valid name."
elif [[ ! -f "$table_file" ]]; then
    echo "Error: Table $tbname does not exist."
else
    if [[ ! -f "$records_file" ]]; then
        echo "Error: No data found in the table. Please enter option 4 to insert data first."
    else
        read -p "Enter primary key value: " primary_key_value

        columnName=$(grep ":pk" "$table_file" | cut -d: -f1)
        col_line_number=$(grep -n "^$columnName:" "$table_file" | cut -d: -f1)
        typeset -i i=1
        while true
        do
            if [[ $primary_key_value == $(sed -n "${i}p" "$records_file" | cut -d: -f$col_line_number) ]]; then
                record=$(sed -n "${i}p" "$records_file")
                break
        else
            echo "Primary key is not found"
            exit
            fi
            ((i++))
        done

        # Select Single Column
        read -p "Enter column to update: " column_to_update
        col_line_number=$(grep -n "^$column_to_update:" "$table_file" | cut -d: -f1)
        dtype=$(grep  "^$column_to_update:" "$table_file" | cut -d: -f2)
        

        if [[ -n "$col_line_number" ]]; then
            read -p "Enter new value for $column_to_update: " new_val

            if [[ -z "$new_val" ]]; then
                echo "Error: $column_to_update cannot be empty."
            elif [[ "$dtype" == "int" && ! "$new_val" =~ ^[0-9]+$ ]]; then
                echo "Error: $column_to_update must be an integer."
            else
                if [[ $column_to_update == $columnName ]]; then
                    col_line_number=$(grep -n "^$column_to_update:" "$table_file" | cut -d: -f1)

                    if awk -F: -v col_line_number="$col_line_number" '{print $col_line_number}' "$records_file" | grep -q "$new_val"; then
                        echo "Error: Primary key must be unique. Record with $new_val already exists."
                    else
                        old_val=$(echo "$record" | cut -f$col_line_number -d:)
                        sed -i "s/$old_val/$new_val/g" "$records_file"
                        echo "Record updated successfully."
                    fi
                else
                    old_val=$(echo "$record" | cut -f$col_line_number -d:)
                    sed -i "s/$old_val/$new_val/g" "$records_file"
                    echo "Record updated successfully."
                fi
            fi
        else
            echo "Error: Column $column_to_update not found in the table file."
        fi
    fi
fi
