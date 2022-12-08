#! /usr/bin/env factor -roots=.

USING: kernel sequences prettyprint io.files
    io.encodings.utf8 splitting parser sorting math.order math
    locals advent.tools sets grouping accessors math.ranges
    vectors strings peg.ebnf multiline assocs peg combinators
    memoize arrays ;
IN: advent.day7


TUPLE: cd { dir string } ;
: <cd> ( string -- cd ) cd boa ;

TUPLE: dir { name string } contents ;
: <dir> ( string -- dir ) 0 <vector> dir boa ;

TUPLE: file { size integer } { name string } ;
: <file> ( size name -- file ) file boa ;

TUPLE: ls contents ;
: <ls> ( contents -- ls ) ls boa ;

GENERIC: process ( fs cmd -- fs )

: new-root ( fs -- fs ) [ [ delete-all ] keep "/" <dir> swap push ] keep ;
: up-dir ( fs -- fs ) [ pop* ] keep ;
:: into-dir ( fs name -- fs )
[let
    name fs last contents>> at :> next
    next fs push
    fs ] ;

M:: cd process ( fs cmd -- fs ) fs cmd dir>> {
    { "/" [ new-root ] } 
    { ".." [ up-dir ] }
    [ into-dir ]
} case ;
M:: ls process ( fs cmd -- fs ) cmd contents>> fs [ process ] reduce ;
M:: dir process ( fs cmd -- fs ) cmd cmd name>> fs last contents>> set-at fs ;
M:: file process ( fs cmd -- fs ) cmd cmd name>> fs last contents>> set-at fs ;

GENERIC: compute-size ( cmd -- n )
MEMO: size ( cmd -- n ) compute-size ;

M: dir compute-size contents>> [ second size ] map sum ;
M: file compute-size size>> ;

GENERIC: flatten ( cmd -- seq )
M: dir flatten [ contents>> [ second flatten ] map concat ] keep prefix ;
M: file flatten 1array ;

EBNF: command [=[
    nl="\r\n" | "\n" => [[ ignore ]]
    cd=("cd " ([a-z/.]+):dir nl) => [[ dir >string <cd> ]]
    ls=(("ls" nl) => [[ ignore ]]) (output* => [[ <ls> ]])
    command = ("$ " (cd | ls):cmd) => [[ cmd ]]
    dir = "dir " => [[ ignore ]] [a-z.]+:dir => [[ dir >string <dir> ]]
    file = ([0-9]+:size " " [a-z.]+:name) => [[ size parse-number name >string <file> ]]
    output = (dir | file) (nl? => [[ ignore ]])
    lines = command+
]=]

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

:: solve ( day input -- ) day input filename utf8 file-contents dup . dup
    part-one . part-two . ;

: main ( -- ) "day7" "input.txt" solve ;

MAIN: main