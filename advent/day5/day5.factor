#! /usr/bin/env factor -roots=.

USING: kernel sequences prettyprint io.files
    io.encodings.utf8 splitting parser sorting math.order math
    locals advent.tools sets grouping accessors math.ranges
    vectors strings ;
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
    amount 0 >
    [ from pop
      to push
      from to
      amount 1 -
      move-boxes ]
    when ;

:: run-command ( stacks from to amount -- stacks )
    from stacks pick-stack
    to stacks pick-stack
    amount move-boxes
    stacks ;

:: run-command-2 ( stacks from to amount -- stacks )
    [let V{ } :> temp
        from stacks pick-stack temp amount move-boxes
        temp to stacks pick-stack amount move-boxes
    ] stacks ;

:: execute-command ( puzzle command -- puzzle )
    puzzle [ command [ from>> ] [ to>> ] [ amount>> ] tri run-command ] change-stacks ;

:: execute-command-2 ( puzzle command -- puzzle )
    puzzle [ command [ from>> ] [ to>> ] [ amount>> ] tri run-command-2 ] change-stacks ;

: run-steps ( puzzle -- puzzle ) dup steps>> [ execute-command ] each ;
: run-steps-2 ( puzzle -- puzzle ) dup steps>> [ execute-command-2 ] each ;

: stack-tops ( puzzle -- seq ) stacks>> [ ?last ] map sift >string ;

: part-one ( seq -- n ) initialize-puzzle run-steps stack-tops ;
: part-two ( seq -- n ) initialize-puzzle run-steps-2 stack-tops ;

:: solve ( day input -- ) day input filename load-input dup
    part-one . part-two . ;

: main ( -- ) "day5" "input.txt" solve ;

MAIN: main