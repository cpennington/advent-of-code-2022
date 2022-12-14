#! /usr/bin/env factor -roots=.

USING: kernel sequences prettyprint io.files
    io.encodings.utf8 splitting parser sorting math.order math
    locals advent.tools sets grouping accessors ranges
    vectors strings peg.ebnf multiline assocs peg combinators
    memoize arrays sequences.repeating math.functions io ;
IN: advent.day10

: noop-cycles ( cur instruction -- cycles ) drop 1array ;
: addx-cycles ( cur instruction -- cycles ) " " split last parse-number [ dup ] dip + 2array ;

: instruction-cycles ( cur instruction -- cycles ) dup "noop" =
    [ noop-cycles ]
    [ addx-cycles ]
    if ;
: code-cycles ( code init -- cycles ) 1vector [ [ dup last ] dip instruction-cycles swap [ push-all ] keep ] reduce ;
:: signal-strength ( cycles targets -- n ) targets [ 1 - ] map cycles nths targets zip [ first2 * ] map sum ;

: pixel-on? ( pixel signal -- ? ) - [-1,1]? ;
: pixel-value ( pixel signal -- b ) pixel-on? CHAR: # 32 ? ;
: scan-value ( ix signal -- b ) 40 rem swap pixel-value ;
: display ( cycles -- str ) [ scan-value ] map-index 40 group "\n" join ;

: part-one ( seq -- n ) 1 code-cycles 20 220 40 <range> signal-strength ;
: part-two ( seq -- n ) 1 code-cycles display print ;

: solve ( day input -- ) filename utf8 file-lines dup
    part-one . part-two . ;

: main ( -- ) "day10" "input.txt" solve ;

MAIN: main