#!/bin/bash
clear
echo "*****************Bash Shell Script DMBS******************"
PS3="Enter your choice: "

select choice in "create database" "list database" "connect to database" "drop database" "exit"
do
         case $REPLY in
              1)./db_func/db_create.sh
	         ;;
              2)./db_func/db_list.sh
                 ;;
              3)./table_func/db_connect.sh
	         ;;
              4)./db_func/db_drop.sh
	         ;;
              5) exit
	         ;;
              * ) echo $REPLY is not on the menu
                 ;;
          esac
done
