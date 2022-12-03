#! /usr/bin/env factor -roots=.

USING: kernel sequences prettyprint io.files
    io.encodings.utf8 splitting parser sorting math.order math
    locals advent.tools sets grouping ;
IN: advent.day3

: in-both-compartments ( seq -- c ) halves intersect ;
: priority ( c -- n ) dup CHAR: A CHAR: Z between?
    [ CHAR: A - 27 + ]
    [ CHAR: a - 1 + ]
    if ;

: part-one ( seq -- n ) [ in-both-compartments first priority ] map sum ;
: part-two ( seq -- n ) 3 group [ first3 intersect intersect first priority ] map sum ;

:: solve ( day input -- ) day input filename load-input dup
    part-one . part-two . ;

: main ( -- ) "day3" "input.txt" solve ;

MAIN: main