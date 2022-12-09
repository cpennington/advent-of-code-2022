#! /usr/bin/env factor -roots=.
USING: tools.test advent.day8 advent.tools arrays ;
IN: advent.day8.tests

{ 21 } [ "day8" "sample.txt" filename utf8 file-contents part-one ] unit-test
{ 8 } [ "day8" "sample.txt" filename utf8 file-contents part-two ] unit-test

: main ( -- ) "advent.day8" test ;

MAIN: main