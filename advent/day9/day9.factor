#! /usr/bin/env factor -roots=.

USING: kernel sequences prettyprint io.files
    io.encodings.utf8 splitting parser sorting math.order math
    locals advent.tools sets grouping accessors ranges
    vectors strings peg.ebnf multiline assocs peg combinators
    memoize arrays sequences.repeating ;
IN: advent.day9

TUPLE: vec2 { x integer read-only } { y integer read-only } ;
: <vec2> ( x y -- vec2 ) vec2 boa ;

TUPLE: rope { head vec2 } { tail vec2 } ;
: <rope> ( head tail -- rope ) rope boa ;

: 0rope ( -- rope ) 0 0 <vec2> 0 0 <vec2> <rope> ;
: 0arope ( -- arope ) 0 0 <vec2> 0 0 <vec2> 2array ;
: nrope ( n -- arope ) [ 0 0 <vec2> ] replicate ;

: parse-digit ( char -- n ) CHAR: 0 - ;
:: bin-op ( x y p -- n ) x y [ [ x>> ] bi@ p call( n n -- n ) ] [ [ y>> ] bi@ p call( n n -- n ) ] 2bi <vec2> ; inline
: v- ( x y -- z ) [ - ] bin-op ; inline
: v+ ( x y -- z ) [ + ] bin-op ; inline

: clamp-unit ( n -- n ) -1 1 clamp ;
: clamp-tail-move ( vec -- vec ) [ x>> ] [ y>> ] bi [ clamp-unit ] bi@ <vec2> ;
: should-tail-move? ( vec -- ? ) [ x>> ] [ y>> ] bi [ -1 1 between? not ] bi@ or ;
: move-tail-direction ( head tail -- vec2 ) v- dup should-tail-move? [ clamp-tail-move ] [ drop 0 0 <vec2> ] if ;
: move-tail ( head tail -- tail ) [ move-tail-direction ] keep v+ ;
: move-dir ( dir -- vec ) {
    { CHAR: L [ -1 0 <vec2> ] }
    { CHAR: R [ 1 0 <vec2> ] }
    { CHAR: U [ 0 1 <vec2> ] }
    { CHAR: D [ 0 -1 <vec2> ] }
} case ;
: move-head ( head dir -- head ) move-dir v+ ;
:: move-rope ( rope dir -- rope )
    rope head>> dir move-head ! move the head
    dup ! save the head
    rope tail>> move-tail ! move the tail
    <rope> ;
:: move-arope ( seq dir -- seq )
    seq first dir move-head ! move the head
    dup ! save the head
    seq rest swap [ move-tail ] accumulate* ! move the tail
    swap prefix ;

: move-seq ( command -- seq ) [ first 1array ] [ rest rest parse-number ] bi repeat ;

: part-one ( seq -- n ) [ move-seq ] map concat 2 nrope [ move-arope ] accumulate* [ last ] map members length ;
: part-two ( seq -- n ) [ move-seq ] map concat 10 nrope [ move-arope ] accumulate* [ last ] map members length ;

: solve ( day input -- ) filename utf8 file-lines dup
    part-one . part-two . ;

: main ( -- ) "day9" "input.txt" solve ;

MAIN: main