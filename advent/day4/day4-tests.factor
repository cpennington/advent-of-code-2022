#! /usr/bin/env factor -roots=.
USING: tools.test advent.day4 advent.tools arrays ;
IN: advent.day4.tests

1 3 <range> 1array [ "1-3" parse-range ] unit-test

{ 2 } [ "day4" "sample.txt" filename load-input part-one ] unit-test
{ 4 } [ "day4" "sample.txt" filename load-input part-two ] unit-test

: main ( -- ) "advent.day4" test ;

MAIN: main