#! /usr/bin/env factor -roots=.
USING: tools.test advent.day6 advent.tools arrays ;
IN: advent.day6.tests

{ 5 } [ "bvwbjplbgvbhsrlpgdmjqwftvncz" part-one ] unit-test
{ 6 } [ "nppdvjthqldpwncqszvftbrmjlhg" part-one ] unit-test
{ 10 } [ "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg" part-one ] unit-test
{ 11 } [ "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw" part-one ] unit-test

{ 23 } [ "bvwbjplbgvbhsrlpgdmjqwftvncz" part-two ] unit-test
{ 23 } [ "nppdvjthqldpwncqszvftbrmjlhg" part-two ] unit-test
{ 29 } [ "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg" part-two ] unit-test
{ 26 } [ "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw" part-two ] unit-test

{ 7 } [ "day6" "sample.txt" filename utf8 file-contents part-one ] unit-test
{ 19 } [ "day6" "sample.txt" filename utf8 file-contents part-two ] unit-test

: main ( -- ) "advent.day6" test ;

MAIN: main