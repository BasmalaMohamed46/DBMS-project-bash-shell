#!/bin/bash

# Execute the list_tb.sh script from the TBprocesses directory
../TB_dir/listTable.sh

# Check if x is not equal to 1
if [ "$x" -ne 1 ]; then
    read -p "Enter the table you want to delete: " tbname

    if [ -z "$tbname" ]; then
        echo "Error: Table name cannot be empty. Please enter table name."
    elif [ -f "$HOME/db_dir/$1/$tbname" ]; then
        read -p "Are you sure you want to delete the table '$tbname'? (y/n): " choice

        case $choice in
            [Yy]* )
                rm "$HOME/db_dir/$1/$tbname"
                echo "Table $tbname has been deleted."
                ;;
            [Nn]* )
                echo "Operation Canceled. Table '$tbname' was not deleted."
                ;;
            * )
                echo "Invalid Input. Operation Canceled."
                ;;
        esac
    else
        echo "Error: Table $tbname does not exist."
    fi
fi
