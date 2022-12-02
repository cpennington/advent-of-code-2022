USING: kernel sequences prettyprint io.files
    io.encodings.utf8 splitting parser sorting math.order math
    locals ;
IN: advent.day1

: parse-numbers ( seq -- seq ) [ parse-number ] map ;

: backpack-items ( seq -- seq ) { "" } split [ parse-numbers ] map ;

: backpack-totals ( seq -- seq ) [ sum ] map ;

: part-one ( seq -- n ) backpack-items backpack-totals supremum ;
: part-two ( seq -- n ) backpack-items backpack-totals [ >=< ] sort first3 + + ;

: load-input ( x -- seq ) utf8 file-lines ;
:: filename ( day input -- x ) { "advent" day input } "/" join ;

:: solve ( day input -- ) day input filename load-input dup
    part-one . part-two . ;

: main ( -- ) "day1" "input.txt" solve ;

MAIN: main