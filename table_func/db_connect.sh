#!/bin/bash

. ./db_func/db_list.sh

PS3="Enter your operation (tables): "
read -p "Enter your choice (1 to connect to a database, 2 to exit): " x

if [ "$x" -eq 1 ]
then
  if [ "$flag" -eq 1 ]
  then
    read -p "Enter the database you want to connect: " dbname
  
    if [ -z "$dbname" ] 
    then
        echo "Error: You cannot enter an empty value. Please enter a valid name."
    elif [ -d $HOME/db_dir/$dbname ] 
    then
        select choice in "create table" "list tables" "drop table" "insert record" "Delete from table" "Select from table" "exit"; do
            case $REPLY in
                1) ./TB_dir/createTable.sh "$dbname" ;;
                2) ./TB_dir/listTable.sh "$dbname" ;;
                3) ./TB_dir/dropTable.sh "$dbname" ;;
                4) ./TB_dir/insertTable.sh "$dbname";;
                5) ./TB_dir/insertTable.sh "$dbname" ;;
                6) ./TB_dir/retrieve_data.sh "$dbname" ;;
                7) exit ;;
                *) echo "$REPLY is not on the menu" ;;
            esac
        done
    else
        echo "Error: The DB $dbname does not exist."
    fi
fi
elif [ "$x" -eq 2 ]
then
    echo "Exiting the script."
    exit
else
    echo "Invalid choice. Please enter 1 or 2."
fi
