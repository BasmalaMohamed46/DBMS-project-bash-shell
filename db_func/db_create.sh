#!/bin/bash
read -p "Enter Database name: " dbname
if [ -z "$dbname" ] || [[ "$dbname" =~ [/.:\\-] ]]
then
echo "Error: Database name cannot be empty or have special characters. Please enter a valid name."
elif [ -d $HOME/db_dir/$dbname ]
then
echo "The Database $dbname already exists"
else
mkdir $HOME/db_dir/$dbname
echo "The DB is created successfully"
fi
