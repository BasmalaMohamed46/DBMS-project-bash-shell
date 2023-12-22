#!/bin/bash

read -p "Enter Table Name: " tbname

script_dir="DBMS"

if [[ -z "$tbname" || "$tbname" =~ [/.:\\-] ]]; then
    echo "Error: Table name cannot be empty or have special characters. Please enter a valid name."
elif [[ -f "$HOME/$script_dir/db_dir/$1/$tbname" ]]; then
    echo "Table $tbname already exists."
else
    touch "$HOME/$script_dir/db_dir/$1/$tbname"

    read -p "Enter Number of columns: " n
    primary_key_set=false
    selected_primary_key=""

    for ((i = 1; i <= n; i++)) 
    do
        read -p "Enter column $i name: " name
        while true 
        do
            read -p "Enter column datatype [string/int]: " dtype

            if [[ "$dtype" =~ ^[Ii][Nn][Tt]$ || "$dtype" =~ ^[Ss][Tt][Rr][Ii][Nn][Gg]$ ]]; then
                break
            else
                echo "Invalid datatype. Please enter 'string' or 'int'."
            fi
        done

        if [[ "$primary_key_set" == false ]]; then
            read -p "Do you want to set $name as the primary key? (y/n): " is_pk
            if [[ "$is_pk" =~ ^[Yy]$ ]]; then
                selected_primary_key="$name"
                primary_key_set=true
            fi
        fi

        if [[ "$name" == "$selected_primary_key" ]]; then
            echo "$name:$dtype:pk" >> "$HOME/$script_dir/db_dir/$1/$tbname"
        else
            echo "$name:$dtype" >> "$HOME/$script_dir/db_dir/$1/$tbname"
        fi
    done

    if [[ "$primary_key_set" == false ]]; then
        echo "Error: No primary key set. Please choose a primary key column."
        rm "$HOME/$script_dir/db_dir/$1/$tbname"  # Rollback, remove the table file
    else
        echo "$tbname table has been created in the $1 database with $selected_primary_key as the primary key."
    fi
fi
