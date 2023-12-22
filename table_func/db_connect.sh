#!/bin/bash

script_dir="DBMS"

. ./$script_dir/db_func/db_list.sh

while true; do
    PS3="Enter your operation (tables): "
    read -p "Enter your choice (1 to connect to a database, 2 to exit): " x

    if [[ "$x" =~ ^[1-2]$ ]]; then
        break
    else
        echo "Invalid choice. Please enter 1 or 2."
    fi
done

if [ "$x" -eq 1 ]; then
    while true; do
        if [ "$flag" -eq 1 ]; then
            read -p "Enter the database you want to connect: " dbname

            if [ -z "$dbname" ]; then
                echo "Error: You cannot enter an empty value. Please enter a valid name."
            elif [ -d $HOME/$script_dir/db_dir/$dbname ]; then
                select choice in "create table" "list tables" "drop table" "insert record" "Delete from table" "Select from table" "Update table" "exit"; do
                    case $REPLY in
                        1) ./$script_dir/TB_dir/createTable.sh "$dbname" ;;
                        2) ./$script_dir/TB_dir/listTable.sh "$dbname" ;;
                        3) ./$script_dir/TB_dir/dropTable.sh "$dbname" ;;
                        4) ./$script_dir/TB_dir/insertTable.sh "$dbname" ;;
                        5) ./$script_dir/TB_dir/deleteTable.sh "$dbname" ;;
                        6) ./$script_dir/TB_dir/selectTable.sh "$dbname" ;;
                        7) ./$script_dir/TB_dir/updateTable.sh "$dbname" ;;
                        8) exit ;;
                        *) echo "$REPLY is not on the menu" ;;
                    esac
                done
            else
                echo "Error: The DB $dbname does not exist."
            fi

            break
        fi
    done
elif [ "$x" -eq 2 ]; then
    echo "Exiting the script."
    exit
fi
