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
: height ( col row grid -- n ) [ map>> nth nth parse-digit ] 0 if-in-grid ;
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

MEMO:: max-north ( col row grid -- n )
    col row 1 - grid [ height ] [ max-north ] 3bi max ;

MEMO:: max-south ( col row grid -- n )
    col row 1 + grid [ height ] [ max-south ] 3bi max ;

MEMO:: max-east ( col row grid -- n )
    col 1 + row grid [ height ] [ max-east ] 3bi max ;

MEMO:: max-west ( col row grid -- n )
    col 1 - row grid [ height ] [ max-west ] 3bi max ;

:: visible? ( col row grid -- ? ) [let
    col row grid sight-lines [ [ first2 grid height ] map ] map :> neighbor-heights
    col row grid height :> this-height
    neighbor-heights .
    this-height .
    neighbor-heights [ [ this-height < ] all? ] any?
] ;

: part-one ( seq -- n )
    command ! parse
    dup . ! print for debugging
    V{ } [ process ] reduce first ! convert to a filesystem tree
    flatten ! get all the files and directories
    [ dir? ] filter ! get only directories
    [ size ] map ! get sizes
    [ 100000 <= ] filter ! find small directories
    sum ;
: part-two ( seq -- n ) 
    command ! parse
    dup . ! print for debugging
    V{ } [ process ] reduce first ! convert to a filesystem tree
    [| fs |
        [let
            70000000 fs size - :> available
            30000000 available - :> required
            fs flatten [ dir? ] filter :> dirs
            dirs [ size ] map [ required >= ] filter infimum
        ]
    ] call ;

:: solve ( day input -- ) day input filename utf8 file-lines dup . dup
    part-one . part-two . ;

: main ( -- ) "day8" "input.txt" solve ;

MAIN: main