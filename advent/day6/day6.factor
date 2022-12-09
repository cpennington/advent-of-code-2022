#! /usr/bin/env factor -roots=.

USING: kernel sequences prettyprint io.files
    io.encodings.utf8 splitting parser sorting math.order math
    locals advent.tools sets grouping accessors math
    vectors strings ;
IN: advent.day6

: part-one ( seq -- n ) 4 clump [ all-unique? ] map [ ] find drop 4 + ;
: part-two ( seq -- n ) 14 clump [ all-unique? ] map [ ] find drop 14 + ;

:: solve ( day input -- ) day input filename utf8 file-contents dup
    part-one . part-two . ;

: main ( -- ) "day6" "input.txt" solve ;

MAIN: main