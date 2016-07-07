" Vim indent file
" Language:    Ninja Build Description
" Maintainer:  Siôn Le Roux <sion.leroux@schibsted.hu>
" Created:     29 October 2013
" Last Change: 07 November 2013

if exists("b:did_indent")
    finish
endif
let b:did_indent = 1

setlocal indentexpr=GetNinjaIndent(v:lnum)
setlocal indentkeys&
setlocal indentkeys+==0(,0),0[,0]

" don't override myself
if exists("*GetNinjaIndent")
    finish
endif

function! s:GetPrevNonCommentLineNum( line_num )
    " Skip lines starting with a comment
    let SKIP_LINES = '^\s*#' " line starting with whitespace then hash

    let nline = a:line_num
    while nline > 0
        let nline = prevnonblank(nline-1)
        if getline(nline) !~? SKIP_LINES
            break
        endif
    endwhile

    return nline
endfunction

function! GetNinjaIndent( line_num )

    " Line 1 always goes at column 0
    if a:line_num <= 1
        return 0
    endif

    let this_codeline = getline( a:line_num )
    let prev_codeline_num = s:GetPrevNonCommentLineNum( a:line_num )
    let prev_codeline = getline( prev_codeline_num )
    let ident = indent( prev_codeline_num )
    let v:statusmsg = "0"

    " Lines with comments always go at column 0
    if this_codeline =~ '^\s*#'
        return 0
    endif

    " count the number of opening brackets ( or [ on previous line
    exec prev_codeline_num.'s/[[(]//gn'
    let l:openbrackets = split(v:statusmsg)[0]
    let v:statusmsg = "0"

    " those opening brackets don't count if they were closed on the same line
    if l:openbrackets > 0
        exec prev_codeline_num.'s/[)\]]//gn'
        let l:openbrackets = ( l:openbrackets - split(v:statusmsg)[0] )
        let v:statusmsg = "0"
    endif

    " count the number of closing brackets ) or ] on the current line
    exec a:line_num.'s/[)\]]//gn'
    let l:closebrackets = split(v:statusmsg)[0]
    let v:statusmsg = "0"

    " those closing brackets don't count if they were also opened on this line
    if l:closebrackets > 0
        exec a:line_num.'s/[[(]//gn'
        let l:closebrackets = ( l:closebrackets - split(v:statusmsg)[0] )
        let v:statusmsg = "0"
    endif

    " the change in indent is the number of open brackets - close brackets
    let l:identchange = (l:openbrackets - l:closebrackets)
    " we need to multiply that by the user's shiftwidth first though
    let weightedchange = (identchange * &shiftwidth)
    " now we set the new indent using the previous codeline's indent and our
    " calculated change value
    return (ident + weightedchange)

    " This line is for debugging and echoes out all important vars to
    " :messages. To use it, move it to before the return statement above.
    echom "thisline:".a:line_num." prevline:".prev_codeline_num." prev:".ident." open:".l:openbrackets." close:".l:closebrackets." change:".l:identchange." weighted:".weightedchange." result:".(ident + weightedchange)

endfunction
