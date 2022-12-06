#! /usr/bin/env factor -roots=.
USING: tools.test advent.day5 advent.tools arrays ;
IN: advent.day5.tests

{ "CMZ" } [ "day5" "sample.txt" filename load-input part-one ] unit-test
{ "MCD" } [ "day5" "sample.txt" filename load-input part-two ] unit-test

: main ( -- ) "advent.day5" test ;

MAIN: main