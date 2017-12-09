augroup filetypedetect
    au BufRead, BufNewFile *.py setfiletype python
    au BufRead, BufNewFile *.js setfiletype js
    au BufRead, BufNewFile *.jsx setfiletype js
    au BufRead, BufNewFile *.html setfiletype html
    au BufRead, BufNewFile *.htm setfiletype html
augroup END
