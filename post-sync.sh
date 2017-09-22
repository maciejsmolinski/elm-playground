#!/bin/bash

CURRENT_DIR=$(pwd)

for project in match-events random-user todo;
do
    cd $CURRENT_DIR/$project && npm run setup && npm run build;
done
