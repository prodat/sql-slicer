#!/bin/bash

#awk '{ if (match($0,/--: (.*)$/,a)) { count+=10; print > sprintf("%03d-%s",count,substr($0,RSTART + 4,RLENGTH)); } };' OFS='--:' ../10_tabk.resource_timeline.sql
awk '{ if (match($0,/--: (.*)$/,a)) { file=a[1]; count+=10 } print $0 > sprintf("%03d-%s",count,file); };' FS='--:' ../10_tabk.resource_timeline.sql
