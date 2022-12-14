#! /usr/bin/env factor -roots=.

USING: kernel sequences prettyprint io.files
    io.encodings.utf8 splitting parser sorting math.order math
    locals advent.tools ;
IN: advent.day2

: p1-play ( x -- n ) "ABC" index ;
: p2-play ( x -- n ) "XYZ" index ;
:: p2-win ( x y -- n )
    y p2-play x p1-play
    - 1 + 3 + 3 mod 1 - ;
: parse-game ( g -- x y ) first3 swap drop ;
: p2-win-score ( x y -- n ) p2-win 1 + 3 * ;
: p2-play-score ( x y -- n ) p2-play 1 + swap drop ;
:: p2-score ( x y -- n )
    x y p2-win-score
    x y p2-play-score
    + ;
:: target-to-play ( x y -- x z ) x y p2-play 1 - x p1-play + 3 rem "XYZ" nth ;

: part-one ( seq -- n ) [ parse-game p2-score ] map sum ;
: part-two ( seq -- n ) [ parse-game target-to-play p2-score ] map sum ;

:: solve ( day input -- ) day input filename line-input dup
    part-one . part-two . ;

: main ( -- ) "day2" "input.txt" solve ;

MAIN: main