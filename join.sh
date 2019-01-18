#!/bin/bash

IFS=$'\n'
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd workspace

for FILE in $( find -type d -not -iwholename '*.svn*' ); do
    cat "$FILE/"* 2>/dev/null > "$DIR/sources/$FILE"
done;
