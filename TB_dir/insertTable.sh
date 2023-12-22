#!/bin/bash

read -p "Enter Table Name: " tbname

script_dir="DBMS"
table_dir="$HOME/$script_dir/db_dir/$1"
table_file="$table_dir/$tbname"
table_tp="$table_file"

if [[ -z "$tbname" || "$tbname" =~ [/.:\\-] ]]; then
    echo "Error: Table name cannot be empty or have special characters. Please enter a valid name."
elif [[ ! -f "$table_file" ]]; then
    echo "Error: Table $tbname does not exist."
else
    columns=($(cut -d: -f1 "$table_file"))
    datatypes=($(cut -d: -f2 "$table_tp"))
    datatypespk=($(cut -d: -f2,3 "$table_tp"))
    record=""
    primary_key=""

    touch "$table_dir/records_${tbname}.txt"

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
                if [[ "${datatypespk[i]}" == *":pk" ]]; then
                    primary_key="$value"
		    
                fi
                break
            fi
        done
    done

    if grep "^$primary_key:" "$table_dir/records_${tbname}.txt" | cut -d: -f1 | grep -q "^$primary_key$"; then
        echo "Error: Primary key must be unique. Record with $primary_key already exists."
    else
        echo "$record" >> "$table_dir/records_${tbname}.txt"
        echo "Record inserted successfully into $tbname table."
    fi

fi
