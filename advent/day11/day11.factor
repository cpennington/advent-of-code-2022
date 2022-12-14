#! /usr/bin/env factor -roots=.

USING: kernel sequences prettyprint io.files
    io.encodings.utf8 splitting parser sorting math.order math
    locals advent.tools sets grouping accessors ranges
    vectors strings peg.ebnf multiline assocs peg combinators
    memoize arrays sequences.repeating math.functions ;
IN: advent.day11

TUPLE: operation op num ;
: <operation> ( op num -- operation ) operation boa ;

TUPLE: test cond true false ;
: <test> ( cond true false -- test ) test boa ;

TUPLE: monkey index items operation test inspected ;
: <monkey> ( index items operation test -- monkey ) 0 monkey boa ;

:: parse-operation ( op value -- quote )
    op CHAR: * =
    [ value "old" = [ sq ] [ value * ] ? ]
    [ value "old" = [ 2 * ] [ value + ] ? ]
    if ;

EBNF: monkeys [=[
    int=[0-9]+ => [[ parse-number ]]
    index={"Monkey"~ int ":"~}
    starting={"Starting items:"~ {int (","?)~}+}
    operation={"Operation: new = old "~ [*+] (int|"old")} => [[ first2 parse-operation ]]
    cond={"Test: divisible by"~ int}
    true={"If true: throw to monkey"~ int}
    false={"If false: throw to monkey"~ int}
    test={cond true false} => [[ first3 <test> ]]
    monkey={index starting operation test} => [[ first4 <monkey> ]]
    monkeys=monkey+
]=]

: divisible? ( n k -- ? ) rem 0 = ;
: target ( monkey item -- n )
    [ test>> [ true>> ] [ false>> ] [ cond>> ] tri ] dip
    swap divisible? -rot ? ;
:: throw ( monkeys monkey item -- ) item monkey item target monkeys nth items>> push ;
: relief ( item -- item ) 3 /i ;
: inc-inspected ( monkey -- monkey ) [ 1 + ] change-inspected ;
: inspect ( monkey item -- item ) [ inc-inspected ] dip swap operation>> call( n -- n ) ;
: inspect-and-throw ( monkeys monkey item -- ) dupd inspect relief throw ;
: turn-items ( monkeys monkey items -- monkeys monkey items )
        [ ! ( monkeys monkey item -- monkeys monkey )
            [ 2dup ] dip inspect-and-throw 
        ] each V{ } clone ;
: turn ( monkeys monkey -- monkeys monkey ) dup items>> turn-items dupd swap items<< ;
: round ( monkeys -- monkeys ) dup [ turn drop ] each ;

:: relief-2 ( monkeys monkey item -- item ) item monkeys [ test>> cond>> ] map product rem ;
:: inspect-and-throw-2 ( monkeys monkey item -- )
    monkeys monkey
        monkeys monkey
            monkey item inspect
        relief-2
    throw ;
: turn-items-2 ( monkeys monkey items -- monkeys monkey items )
        [ ! ( monkeys monkey item -- monkeys monkey )
            [ 2dup ] dip inspect-and-throw-2
        ] each V{ } clone ;
: turn-2 ( monkeys monkey -- monkeys monkey ) dup items>> turn-items-2 dupd swap items<< ;
: round-2 ( monkeys -- monkeys ) dup [ turn-2 drop ] each ;

: part-one ( seq -- n ) monkeys 20 [ round ] times [ inspected>> ] map natural-sort reverse first2 * ;
: part-two ( seq -- n ) monkeys 10000 [ round-2 ] times [ inspected>> ] map natural-sort reverse first2 * ;

: solve ( filename -- ) file-input dup
    part-one . part-two . ;

: main ( -- ) "day11" input-file solve ;

MAIN: main