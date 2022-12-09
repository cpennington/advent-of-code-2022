#! /usr/bin/env factor -roots=.

USING: kernel sequences prettyprint io.files
    io.encodings.utf8 splitting parser sorting math.order math
    locals advent.tools sets grouping accessors math
    vectors strings ranges ;
IN: advent.day5

TUPLE: puzzle init steps stacks ;
: <puzzle> ( init steps -- puzzle ) { } puzzle boa ;

TUPLE: command amount from to ;
: <command> ( amount from to -- command ) command boa ;

: setup-indexes ( -- range ) 1 100 4 <range> ;
: stack-indexes ( seq -- seq ) " " split [ "" = not ] filter [ parse-number ] map ;
: n-stacks ( n -- seq ) [ 0 <vector> ] replicate ;
: empty-stacks ( puzzle -- puzzle ) dup init>> last stack-indexes supremum n-stacks >>stacks ;
:: row-boxes ( row -- boxes ) setup-indexes [ row length < ] filter row nths ;
:: apply-init-box ( box idx stacks -- ) box 32 = [ box idx stacks nth push ] unless ;
:: apply-init-row ( stacks row -- stacks ) row row-boxes [ stacks apply-init-box ] each-index stacks ;
: initial-stacks ( puzzle -- puzzle ) [ [ stacks>> ] [ init>> ] bi but-last reverse [ apply-init-row ] each drop ] keep ;

: parse-command ( seq -- command ) " " split { 1 3 5 } swap nths [ parse-number ] map first3 <command> ;
: parse-commands ( puzzle -- puzzle ) [ [ parse-command ] map ] change-steps ;

: parse-puzzle ( seq -- puzzle ) { "" } split first2 <puzzle> ;

: initialize-puzzle ( seq -- puzzle )
    parse-puzzle empty-stacks initial-stacks parse-commands ;

: pick-stack ( n stacks -- stack ) [ 1 - ] dip nth ;

:: move-boxes ( from to amount -- )
    amount [
        from pop
        to push
    ] times ;

:: move-box-batch ( from to amount -- )
    [let V{ } :> temp
        from temp amount move-boxes
        temp to amount move-boxes
    ] ;

:: execute-command ( puzzle command strategy -- puzzle )
    puzzle
    [| stacks |
        command
        [ from>> stacks pick-stack ]
        [ to>> stacks pick-stack ]
        [ amount>> ]
        tri strategy call( from to amount -- )
        stacks
    ] change-stacks ;

:: run-steps ( puzzle strategy -- puzzle ) puzzle dup steps>> [ strategy execute-command ] each ;
: stack-tops ( puzzle -- seq ) stacks>> [ ?last ] map sift >string ;

: part-one ( seq -- n ) initialize-puzzle [ move-boxes ] run-steps stack-tops ;
: part-two ( seq -- n ) initialize-puzzle [ move-box-batch ] run-steps stack-tops ;

:: solve ( day input -- ) day input filename load-input dup
    part-one . part-two . ;

: main ( -- ) "day5" "input.txt" solve ;

MAIN: main