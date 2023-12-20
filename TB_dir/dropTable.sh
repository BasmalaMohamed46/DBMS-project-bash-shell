#!/bin/bash

../TB_dir/listTable.sh

delete_table() {
    read -p "Enter the table you want to delete: " tbname

    if [ -z "$tbname" ]; then
        echo "Error: You cannot enter an empty value. Please enter a valid name."
    elif [ -f "$HOME/db_dir/$1/$tbname" ]; then
        read -p "Are you sure you want to delete this table? (y/n): " choice

        case $choice in
            [Yy]* )
                rm "$HOME/db_dir/$1/$tbname"
                echo "$tbname has been deleted."
                ;;
            [Nn]* )
                echo "Operation Canceled."
                ;;
            * )
                echo "Invalid Input. Operation Canceled."
                ;;
        esac
    else
        echo "Error: The table $tbname does not exist."
    fi
}

if [ "$x" -ne 1 ]; then
    delete_table "$1"
fi