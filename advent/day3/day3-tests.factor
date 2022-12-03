#! /usr/bin/env factor -roots=.
USING: tools.test advent.day3 advent.tools ;
IN: advent.day3.tests

{ 27 } [ CHAR: A priority ] unit-test
{ 1 } [ CHAR: a priority ] unit-test

{ "a" } [ "aBCabc" in-both-compartments ] unit-test

{ 157 } [ "day3" "sample.txt" filename load-input part-one ] unit-test
{ 70 } [ "day3" "sample.txt" filename load-input part-two ] unit-test

: main ( -- ) "advent.day3" test ;

MAIN: main