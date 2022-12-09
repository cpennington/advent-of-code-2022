#! /usr/bin/env factor -roots=.

USING: kernel sequences prettyprint io.files
    io.encodings.utf8 splitting parser sorting math.order math
    locals advent.tools sets grouping accessors math.ranges
    vectors strings peg.ebnf multiline assocs peg combinators
    memoize arrays ;
IN: advent.day8

TUPLE: grid map { height integer } { width integer } ;
: <grid> ( string -- grid ) string-lines [ ] [ length ] [ first length ] tri grid boa ;

: parse-digit ( char -- n ) CHAR: 0 - ;
:: in-grid? ( col row grid -- ? )
    col 0 grid width>> 1 - between?
    row 0 grid height>> 1 - between?
    and ;
:: if-in-grid ( col row grid p default -- n )
    col row grid in-grid?
    [ col row grid p call( col row grid -- n ) ]
    [ default ]
    if ;
: height ( col row grid -- n ) [ map>> nth nth parse-digit ] -1 if-in-grid ;
:: look-north ( col row grid -- seq ) col 0 (a,b] [ row 2array ] map ;
:: look-south ( col row grid -- seq ) col grid width>> (a,b) [ row 2array ] map ;
:: look-east ( col row grid -- seq ) row 0 (a,b] [ col swap 2array ] map ;
:: look-west ( col row grid -- seq ) row grid height>> (a,b) [ col swap 2array ] map ;
: sight-lines ( col row grid -- seq ) {
    [ look-north ]
    [ look-south ]
    [ look-east ]
    [ look-west ]
} 3cleave 4array ;

:: coord-heights ( coords grid -- n ) coords [ first2 grid height ] map ;
:: visible-trees ( line height -- n ) [let
    line [ height >= ] find drop :> furthest-visible
    line length :> all-trees
    furthest-visible [ furthest-visible 1 + ] [ all-trees ] if
] ;

:: scenic-score ( col row grid -- n ) [let
    col row grid height :> this-height
    col row grid sight-lines [ grid coord-heights ] map 
    [ this-height visible-trees ] map product
] ;

MEMO: max-north ( col row grid -- n )
    [| col row grid | col row 1 - grid [ height ] [ max-north ] 3bi max ] -1 if-in-grid ;

MEMO: max-south ( col row grid -- n )
    [| col row grid |  col row 1 + grid [ height ] [ max-south ] 3bi max ] -1 if-in-grid ;

MEMO: max-east ( col row grid -- n )
    [| col row grid |  col 1 + row grid [ height ] [ max-east ] 3bi max ] -1 if-in-grid ;

MEMO: max-west ( col row grid -- n )
    [| col row grid |  col 1 - row grid [ height ] [ max-west ] 3bi max ] -1 if-in-grid ;

: min-to-edge ( col row grid -- n )
    [ [ max-north ] [ max-south ] [ max-east ] [ max-west ] ] 3cleave 4array infimum ;

: visible? ( col row grid -- ? ) [ min-to-edge ] [ height ] 3bi < ;
:: solve-part-one ( grid -- n ) 
    0 grid height>> [a,b)
    0 grid width>> [a,b)
    [ swap grid visible? ]
    cartesian-map
    concat
    sift
    length ;

:: solve-part-two ( grid -- n ) 
    0 grid height>> [a,b)
    0 grid width>> [a,b)
    [ swap grid scenic-score ]
    cartesian-map
    concat
    supremum ;

: part-one ( seq -- n )
    <grid>
    solve-part-one ;
: part-two ( seq -- n ) 
    <grid>
    solve-part-two ;

: solve ( day input -- ) filename utf8 file-contents dup
    part-one . part-two . ;

: main ( -- ) "day8" "input.txt" solve ;

MAIN: main