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

        if ( match($0,/CREATE OR REPLACE FUNCTION ([a-zA-Z0-9_\.\s]+)/,a) ) { 

            # print $0;
            file=a[1]; 
            count += 10;
        
        }

        # print count ": " a[1];

        print $0 > sprintf("%04d-%s.sql",count,file); 

    };' "$DIR/sources/$FILE"

done;
