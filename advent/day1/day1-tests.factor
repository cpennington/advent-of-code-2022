#! /usr/bin/env factor -roots=.
USING: tools.test advent.day1 advent.tools ;
IN: advent.day1.tests

{ 24000 } [ "day1" "sample.txt" filename line-input part-one ] unit-test
{ 45000 } [ "day1" "sample.txt" filename line-input part-two ] unit-test

: main ( -- ) "advent.day1" test ;

MAIN: main