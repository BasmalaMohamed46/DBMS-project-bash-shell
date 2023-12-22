#!/bin/bash
script_dir="DBMS"
. ./$script_dir/db_func/db_list.sh


if [ "$flag" -eq 1 ]
then
    read -p "Enter the database you want to delete: " dbname
    if [ -z "$dbname" ]
    then
        echo "Error: you cannot enter empty value.please enter a valid name."
    elif [ -d $HOME/$script_dir/db_dir/$dbname ]
    then
        read -p "Are you sure you want to delete this DB? y/n: " choice
        case $choice in
        [Yy]* )
        rm -r $HOME/$script_dir/db_dir/$dbname
        echo "$dbname has been deleted"
        ;;
        [Nn]* )
        echo "Operation Canceled"
        ;;
        * )
        echo "Invalid Input" 
        ;;
        esac
    else
        echo "The DB $dbname does not exist"
    fi
fi
