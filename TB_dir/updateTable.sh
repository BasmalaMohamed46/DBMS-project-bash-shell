#!/bin/bash

function update_record {
    read -p "Enter primary key value for the record to update: " primary_key_value

    echo "Existing Record:"
    grep "^$primary_key_value:" "$records_file"

    read -p "Enter column to update: " column_to_update

    # Check if the chosen column exists in the table file
    col_metadata=$(grep "^$column_to_update:" "$table_file")
    if [[ -z "$col_metadata" ]]; then
        echo "Error: Column $column_to_update not found in the table file."
        return
    fi

    col_index=$(echo "$col_metadata" | cut -d: -f1)

    # If the chosen column is the primary key, check for duplication
    if [[ "$column_to_update" == "$selected_primary_key" ]]; then
        read -p "Enter new value for $column_to_update: " new_value
        if grep -q "^$new_value:" "$records_file"; then
            echo "Error: Updated primary key value already exists. Duplicates are not allowed."
            return
        fi
    else
        read -p "Enter new value for $column_to_update: " new_value
    fi

    # Update the record in the records file
    awk -F: -v col_index="$col_index" -v new_value="$new_value" -v line_number="$record_line_number" \
        '{if (NR == line_number) $col_index = new_value; print}' "$records_file" > temp_records
    mv temp_records "$records_file"

    echo "Record updated successfully."
}

read -p "Enter Table Name: " tbname

table_dir="$HOME/db_dir/$1"
table_file="$table_dir/$tbname"
records_file="$table_dir/records.txt"

if [[ -z "$tbname" || "$tbname" =~ [/.:\\-] ]]; then
    echo "Error: Table name cannot be empty or have special characters. Please enter a valid name."
elif [[ ! -f "$table_file" ]]; then
    echo "Error: Table $tbname does not exist."
else
    read -p "Enter primary key column name: " selected_primary_key

    # Validate if the primary key column exists in the table file
    if ! grep -q "^$selected_primary_key:" "$table_file"; then
        echo "Error: Primary key column $selected_primary_key not found in the table file."
        exit
    fi

    update_record
fi
