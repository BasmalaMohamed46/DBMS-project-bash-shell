#!/bin/bash
clear
echo "*****************Bash Shell Script DMBS******************"
PS3="Enter your choice (Database): "
script_dir="DBMS"

select choice in "create database" "list database" "connect to database" "drop database" "exit"
do
         case $REPLY in
              1)./"$script_dir"/db_func/db_create.sh
	         ;;
              2)./"$script_dir"/db_func/db_list.sh
                 ;;
              3)./"$script_dir"/table_func/db_connect.sh
	         ;;
              4)./"$script_dir"/db_func/db_drop.sh
	         ;;
              5) exit
	         ;;
              * ) echo $REPLY is not on the menu
                 ;;
          esac
done
