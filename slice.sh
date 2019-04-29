#!/bin/bash

IFS=$'\n'

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

rm workspace -rf
cd sources

for FILE in $(find */* -name '*.sql' -type f -not -iwholename '*.svn*' ); do

    mkdir -p "$DIR/workspace/$(dirname $FILE)"
    cd "$DIR/workspace/$(dirname $FILE)"

    mkdir "$(basename $FILE)"
    cd "$(basename $FILE)"

    echo "$DIR/sources/$FILE"

    awk '{ 

        if ( !file ) { 
            count = 0;
            file = "head"; 
        } 

        if ( match($0,/CREATE (OR REPLACE FUNCTION|TABLE) ([a-zA-Z0-9_\.\s]+)/,a) ) { 

            # print $0 $1;
            file   = a[2]; 
            count += 10;

            # print count ": " a[2];

            if ( match(a[1],/TABLE/ ) ) {
              type = "table";
            } else {
              type = "function";
            }
        }



        print $0 > sprintf("%04d-%s-%s.sql",count,type,file); 

    };' "$DIR/sources/$FILE"

done;
