USING: kernel sequences prettyprint io.files
    io.encodings.utf8 splitting parser sorting math.order math
    locals io.directories ;
IN: advent.tools

: set-dir ( -- ) "~/personal/advent-of-code-2022" set-current-directory ;
: line-input ( x -- seq ) set-dir utf8 file-lines ;
: file-input ( x -- file ) set-dir utf8 file-contents ;
:: filename ( day input -- x ) { "advent" day input } "/" join ;
: input-file ( day -- file ) "input.txt" filename ;
: sample-file ( day -- file ) "sample.txt" filename ;