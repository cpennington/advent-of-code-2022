#! /usr/bin/env factor -roots=.
USING: tools.test advent.day9 advent.tools arrays io.encodings.utf8 io.files accessors kernel sequences ;
IN: advent.day9.tests

{ f } [ 1 1 <vec2> should-tail-move? ] unit-test
{ t } [ 2 0 <vec2> should-tail-move? ] unit-test

: final-tail ( str -- x y ) >array 0rope [ move-rope ] accumulate* last tail>> [ x>> ] [ y>> ] bi ;
{ 0 0 } [ "U" final-tail ] unit-test
{ 0 1 } [ "UU" final-tail ] unit-test
{ 1 1 } [ "URU" final-tail ] unit-test
{ -1 1 } [ "ULU" final-tail ] unit-test
{ 0 0 } [ "D" final-tail ] unit-test
{ 0 -1 } [ "DD" final-tail ] unit-test
{ 1 -1 } [ "DRD" final-tail ] unit-test
{ -1 -1 } [ "DLD" final-tail ] unit-test
{ 0 0 } [ "L" final-tail ] unit-test
{ -1 0 } [ "LL" final-tail ] unit-test
{ -1 1 } [ "LUL" final-tail ] unit-test
{ -1 -1 } [ "LDL" final-tail ] unit-test
{ 0 0 } [ "R" final-tail ] unit-test
{ 1 0 } [ "RR" final-tail ] unit-test
{ 1 1 } [ "RUR" final-tail ] unit-test
{ 1 -1 } [ "RDR" final-tail ] unit-test

{ 1 1 } [ "URUD" final-tail ] unit-test
{ -1 1 } [ "ULUD" final-tail ] unit-test
{ 1 -1 } [ "DRDU" final-tail ] unit-test
{ -1 -1 } [ "DLDU" final-tail ] unit-test
{ -1 1 } [ "LULR" final-tail ] unit-test
{ -1 -1 } [ "LDLR" final-tail ] unit-test
{ 1 1 } [ "RURL" final-tail ] unit-test
{ 1 -1 } [ "RDRL" final-tail ] unit-test

{ 1 1 } [ "URUL" final-tail ] unit-test
{ -1 1 } [ "ULUR" final-tail ] unit-test
{ 1 -1 } [ "DRDL" final-tail ] unit-test
{ -1 -1 } [ "DLDR" final-tail ] unit-test
{ -1 1 } [ "LULD" final-tail ] unit-test
{ -1 -1 } [ "LDLU" final-tail ] unit-test
{ 1 1 } [ "RURD" final-tail ] unit-test
{ 1 -1 } [ "RDRU" final-tail ] unit-test



{ 13 } [ "day9" "sample.txt" filename utf8 file-lines part-one ] unit-test
{ 13 } [ "day9" "sample.txt" filename utf8 file-lines part-two ] unit-test

: main ( -- ) "advent.day9" test ;

MAIN: main