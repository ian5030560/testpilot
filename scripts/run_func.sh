#!/bin/bash

work_dir=$PWD

function run_testpilot(){
    echo "install dependencies in $1"
    if ! cd "$1"; then
        echo "unabled to reach this package"
        exit
    fi

    npm install
    if ! npm list mocha --depth=0 >/dev/null 2>&1; then
        npm install mocha@10.0.0 --save-dev
    fi
    echo "install finished"

    _pkg=$(wslpath -w "$1")

    echo "start execution of $_pkg"
    if ! cd "$work_dir" ; then
        echo "failed to change to $work_dir"
        exit 1
    fi

    REPORT_ID=$(uuidgen)
    for ((i=0; i<$2; i++)); do
        echo "start No$i execution"
        npm run starcoder -- --outputDir "$_pkg/reports-$REPORT_ID/$i" --package "$_pkg"
        echo "end No$i execution"
    done
    echo "end execution of $_pkg"
}

function assert_dir(){
    if [ ! -e "$1" ]; then
        echo "$1 does not exist"
        exit 1
    fi

    if [ ! -d "$1" ]; then
        echo "$1 is not a directory"
        exit 1
    fi
}