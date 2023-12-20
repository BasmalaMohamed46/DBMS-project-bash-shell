#!/bin/bash

directory="$HOME/db_dir/$1"
x=0

if [ -z "$(ls "$directory")" ]; then
    echo "There are no tables."
    x=1
else
    echo "Tables of the database $1:"
    ls "$directory"
fi

export x
