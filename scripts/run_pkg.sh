#!/bin/bash
source scripts/config.sh
source scripts/run_func.sh

while getopts "d:c:" args; do
    case $args in
        d)
            pkg=$OPTARG 
            ;;
        c)
            count=$OPTARG 
            ;;
        ?)
            echo "Unknown argument" 
            exit 1
        ;;
    esac
done

if [ ! "$count" ]; then
    count=1
fi

if [ ! "$count" -gt 0 ]; then
    echo "count must be greater than 0"
    exit 1
fi

assert_dir "$pkg"

run_testpilot "$pkg" "$count"

exit 0