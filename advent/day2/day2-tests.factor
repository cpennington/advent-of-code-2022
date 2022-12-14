#! /usr/bin/env factor -roots=.
USING: tools.test advent.day2 advent.tools ;
IN: advent.day2.tests

{ 0 } [ CHAR: A p1-play ] unit-test
{ 2 } [ CHAR: Z p2-play ] unit-test

{ 0 } [ "A X" parse-game p2-win ] unit-test
{ 1 } [ "A Y" parse-game p2-win ] unit-test
{ -1 } [ "A Z" parse-game p2-win ] unit-test
{ -1 } [ "B X" parse-game p2-win ] unit-test
{ 0 } [ "B Y" parse-game p2-win ] unit-test
{ 1 } [ "B Z" parse-game p2-win ] unit-test
{ 1 } [ "C X" parse-game p2-win ] unit-test
{ -1 } [ "C Y" parse-game p2-win ] unit-test
{ 0 } [ "C Z" parse-game p2-win ] unit-test

{ 3 } [ "A X" parse-game p2-win-score ] unit-test 
{ 1 } [ "A X" parse-game p2-play-score ] unit-test 
{ 6 } [ "A Y" parse-game p2-win-score ] unit-test 
{ 2 } [ "A Y" parse-game p2-play-score ] unit-test 

{ 4 } [ "A X" parse-game p2-score ] unit-test
{ 8 } [ "A Y" parse-game p2-score ] unit-test
{ 3 } [ "A Z" parse-game p2-score ] unit-test
{ 1 } [ "B X" parse-game p2-score ] unit-test
{ 5 } [ "B Y" parse-game p2-score ] unit-test
{ 9 } [ "B Z" parse-game p2-score ] unit-test
{ 7 } [ "C X" parse-game p2-score ] unit-test
{ 2 } [ "C Y" parse-game p2-score ] unit-test
{ 6 } [ "C Z" parse-game p2-score ] unit-test

{ CHAR: A CHAR: Z } [ "A X" parse-game target-to-play ] unit-test
{ CHAR: A CHAR: X } [ "A Y" parse-game target-to-play ] unit-test
{ CHAR: A CHAR: Y } [ "A Z" parse-game target-to-play ] unit-test
{ CHAR: B CHAR: X } [ "B X" parse-game target-to-play ] unit-test
{ CHAR: B CHAR: Y } [ "B Y" parse-game target-to-play ] unit-test
{ CHAR: B CHAR: Z } [ "B Z" parse-game target-to-play ] unit-test
{ CHAR: C CHAR: Y } [ "C X" parse-game target-to-play ] unit-test
{ CHAR: C CHAR: Z } [ "C Y" parse-game target-to-play ] unit-test
{ CHAR: C CHAR: X } [ "C Z" parse-game target-to-play ] unit-test

{ 15 } [ "day2" "sample.txt" filename line-input part-one ] unit-test
{ 12 } [ "day2" "sample.txt" filename line-input part-two ] unit-test

: main ( -- ) "advent.day2" test ;

MAIN: main