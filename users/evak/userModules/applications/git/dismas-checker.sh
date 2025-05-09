#!/bin/bash
if [ "$__DISMAS_CALLER" = "Y" ]; then
    exit 0
else
    echo "Please run this command using the dismas utility"
    exit 1
fi

echo "Running pre-commmit utility"
pre-commit run