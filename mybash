#!/bin/bash

yacc -d aghax2.y
lex aghax.l
gcc lex.yy.c y.tab.c -o output
echo PARSER STARTED :

./output file > outfile

