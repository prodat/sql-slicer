#!/bin/bash

IFS=$'\n'
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd workspace

for FILE in $( find -type d -not -iwholename '*.svn*' -links 2 ); do
    cat "$FILE/"* > "$DIR/sources/$FILE"
done;
