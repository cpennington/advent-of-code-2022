#! /usr/bin/env factor -roots=.

USING: kernel sequences prettyprint io.files
    io.encodings.utf8 splitting parser sorting math.order math
    locals advent.tools sets grouping accessors ;
IN: advent.day4

TUPLE: range { start integer read-only } { end integer read-only } ;

: <range> ( start end -- range ) range boa ;

: parse-range ( seq -- range ) "-" split first2 [ parse-number ] bi@ <range> ;
: parse-pairs ( seq -- pair pair ) "," split [ parse-range ] map first2 ;

: contains ( large small -- ? ) [ [ start>> ] bi@ <= ] [ [ end>> ] bi@ >= ] 2bi and ;
: either-contained ( range range -- ? ) 2dup swap [ contains ] 2bi@ or ;
: overlaps ( range range -- ? ) [ [ end>> ] [ start>> ] bi* < ] [ [ start>> ] [ end>> ] bi* > ] 2bi or not ;

: part-one ( seq -- n ) [ parse-pairs either-contained 1 0 ? ] map sum ;
: part-two ( seq -- n ) [ parse-pairs overlaps 1 0 ? ] map sum ;

:: solve ( day input -- ) day input filename load-input dup
    part-one . part-two . ;

: main ( -- ) "day4" "input.txt" solve ;

MAIN: main