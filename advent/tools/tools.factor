USING: kernel sequences prettyprint io.files
    io.encodings.utf8 splitting parser sorting math.order math
    locals ;
IN: advent.tools

: load-input ( x -- seq ) utf8 file-lines ;
:: filename ( day input -- x ) { "advent" day input } "/" join ;
