#! /usr/bin/env factor -roots=.
USING: tools.test advent.day7 advent.tools arrays ;
IN: advent.day7.tests

{ 95437 } [ "day7" "sample.txt" filename utf8 file-contents part-one ] unit-test
{ 24933642 } [ "day7" "sample.txt" filename utf8 file-contents part-two ] unit-test

: main ( -- ) "advent.day7" test ;

MAIN: main