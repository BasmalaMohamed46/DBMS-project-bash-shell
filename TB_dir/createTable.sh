#!/bin/bash

read -p "Enter Table Name: " tbname

if [[ -z "$tbname" || "$tbname" =~ [/.:\\-] ]]; then
    echo "Error: Table name cannot be empty or have special characters. Please enter a valid name."
elif [[ -f "$HOME/db_dir/$1/$tbname" ]]; then
    echo "Table $tbname already exists."
else
    touch "$HOME/db_dir/$1/$tbname"

    read -p "Enter Number of columns: " n

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

        if [[ "$i" -eq "$n" ]]
        then
            echo "$name" >> "$HOME/db_dir/$1/$tbname"
            echo "$dtype" >> "$HOME/db_dir/$1/$tbname.tp"
        else
            echo -n "$name:" >> "$HOME/db_dir/$1/$tbname"
            echo -n "$dtype:" >> "$HOME/db_dir/$1/$tbname.tp"
        fi
    done

    echo "$tbname table has been created in the $1 database."
fi
