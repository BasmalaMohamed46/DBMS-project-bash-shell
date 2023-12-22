#!/bin/bash

read -p "Enter Database name: " dbname
script_dir="DBMS"

valid_dbname() {
  [[ -n "$1" && ! "$1" =~ [/.:\\-] ]]
}

db_exist() {
  [ -d "$HOME/$script_dir/db_dir/$1" ]
}

if valid_dbname "$dbname"
then
  if db_exist "$dbname"
  then
    echo "Error: The Database $dbname already exists."
  else
    mkdir -p "$HOME/$script_dir/db_dir/$dbname" && echo "The DB $dbname is created successfully."
  fi
else
  echo "Error: Database name cannot be empty or have special characters. Please enter a valid name."
fi
