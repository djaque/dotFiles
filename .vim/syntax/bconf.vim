" Vim syntax file
" Language: Blocket Configuration
" Maintainer: Siôn Le Roux <sion.leroux@schibsted.hu>
" Latest Revision: 27 September 2013

" don't override myself
if exists("b:current_syntax")
    finish
endif

" keys
syn match bconfKeyLevel '[a-zA-Z_0-9]' containedin=bconfKeyArea
syn match bconfKeyNumber '^\zs[0-9]*\ze[\.=]' contained containedin=bconfKeyArea
syn match bconfKeyNumber '\.\zs[0-9]*\ze[\.=]' contained containedin=bconfKeyArea
syn match bconfKeyArea '^.*=' contains=bconfError,bconfKeyLevel,bconfKeyNumber,bconfStar,bconfSpecial transparent " only used for highlighting invalid characters
syn match bconfOpEquals '=' nextgroup=bconfValue
syn match bconfStar '\*' contained containedin=bconfKeyArea " an actual asterisk for bconf wildcards

" values
syn match bconfValue '[^\^=.]*$' contains=bconfKeyception,Normal,bconfRegex,bconfEmail

" key-value pairs inside key-value pairs: it's K E Y C E P T I O N
syn match bconfKeyception '[a-z0-9_A-Z]*\ze:'

" regex in value area TODO: smarter regex highlighting
syn region bconfRegex start='\[' end=']'

" email in value area
syn match bconfEmail '[a-z._-]\+@[a-z._-]\+\.[a-z]\+' " e.g. dog@schibsted.hu
syn match bconfEmail '[a-z._-]\+@[a-z._-]\+\.[a-z]\+\.[a-z]\+' " e.g. dog@google.co.uk
syn region bconfBracedEmail start='<' end='>'

" highlight special categories:
syn keyword bconfSpecial cat default keys common modules name
syn keyword bconfSpecial asearch index
syn keyword bconfSpecial host
syn keyword bconfSpecial price cost

" operators
syn match Normal '[:,]' " symbols which shouldn't be highlighted at all

" invalid syntax
syn match bconfError '^.*\.=.*$' " . followed by = (there must be key name between . and =)
syn match bconfError '^=.*$' " = at start of a line (there must be a key name before =)
syn match bconfError '^[^=]* .*$' " a space with no = (you can't have spaces in keys)
syn match bconfError '^.*=.*=.*$' " 2 equals (= is only used to separate key from value)
syn match bconfError '^.*=$' " equals at end of line (you must have a value after equals)
syn match bconfError '^.*[^\.]\*.*=' contained " anything other than a . before an * (only .*. is valid)
syn match bconfError '^.*\*[^\.].*=' contained " anything other than a . after an * (only .*. is valid)
syn match bconfError '^\..*$' " a line starting with a . (line needs to start with a key)
syn match bconfError '[^a-zA-Z0-9_\*.=]' contained " any character not a-zA-Z, 0-9, * or _ found in the key area

" include <> directive
syn match bconfIncludeFile ' .*$' containedin=bconfInclude contained display
syn match bconfInclude '^include .*$' contains=bconfIncludeFile

" comments
syn keyword bconfTodo contained TODO FIXME XXX NOTE WTF
syn match bconfComment "#.*$" contains=bconfTodo

" define syntax name
let b:current_syntax = "bconf"

" link syntax groups to standard colours
hi def link bconfTodo           Todo
hi def link bconfComment        Comment
hi def link bconfSpecial        Identifier
hi def link bconfStar           Statement
hi def link bconfKeyLevel       Type
hi def link bconfKeyNumber      Underlined
hi def link bconfValue          Constant
hi def link bconfInclude        Include
hi def link bconfIncludeFile    Constant
hi def link bconfError          Error
hi def link bconfKeyception     Type
hi def link bconfRegex          Identifier
hi def link bconfEmail          Identifier
hi def link bconfBracedEmail    Identifier
