#!/bin/bash

read -p "Enter Table Name: " tbname

table_dir="$HOME/db_dir/$1"
table_file="$table_dir/$tbname"
table_tp="$table_file"

if [[ -z "$tbname" || "$tbname" =~ [/.:\\-] ]]; then
    echo "Error: Table name cannot be empty or have special characters. Please enter a valid name."
elif [[ ! -f "$table_file" ]]; then
    echo "Error: Table $tbname does not exist."
else
    columns=($(cut -d: -f1 "$table_file"))
    datatypes=($(cut -d: -f2 "$table_tp"))

    record=""
    primary_key=""
    for ((i = 0; i < ${#columns[@]}; i++)); do
        col="${columns[i]}"
        dtype="${datatypes[i]}"

        while true; do
            read -p "Enter $col ($dtype): " value

            if [[ -z "$value" ]]; then
                echo "Error: $col cannot be empty."
            elif [[ "$dtype" == "int" && ! "$value" =~ ^[0-9]+$ ]]; then
                echo "Error: $col must be an integer."
            else
                record+="$value:"
                if [[ "${datatypes[i]}" == *":pk" ]]; then
                    primary_key="$value"
                fi
                break
            fi
        done
    done

    # Check for uniqueness of the primary key
    if grep -q "^$primary_key:" "$table_file"; then
        echo "Error: Primary key must be unique. Record with $primary_key already exists."
    else
        echo "$record" >> "$table_file"
        echo "Record inserted successfully into $tbname table."
    fi
fi