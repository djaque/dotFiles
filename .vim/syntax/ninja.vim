" Vim syntax file
" Language:        Ninja Build Description
" Maintainer:      Siôn Le Roux <sion.leroux@schibsted.hu>
" Created:         15 October 2013
" Latest Revision: 29 October 2013

" don't override myself
if exists("b:current_syntax")
    finish
endif

" descriptors
" TODO: CONFIG and COMPONENT require a name and at least 1 argument
syn keyword ninjaDescriptor CONFIG COMPONENT PROG TOOL_PROG LIB MODULE
syn keyword ninjaDescriptor TEMPLATES INSTALL TOOL_INSTALL
syn region ninjaDescriptor start='(' end=')' transparent fold contains=ninjaArgument,ninjaError,ninjaFlavor

" arguments
syn keyword ninjaArgument contained buildversion_script flavors rules extravars builddir buildvars
syn keyword ninjaArgument contained srcs includes libs deps templates specialsrcs conf
syn keyword ninjaArgument contained copts scripts cwarnflags srcdir destdir tmpldirs
syn keyword ninjaArgument contained INCLUDE nextgroup=ninjaFlavor
syn region ninjaArgument start='\[' end=']' contained fold transparent contains=ninjaError,ninjaVariable

" predefined variables
syn match ninjaVariable '$incdir\|$libdir\|$buildroot\|$buildtools\|$platformdir' contained

" TODO: special highlighting for [.+:.+:.+] in specialvars

" flavors
syn match ninjaFlavor ':\zs[a-z]\+' contained

" comments
syn keyword ninjaTodo contained TODO FIXME XXX NOTE WTF
syn match ninjaComment "#.*$" contains=ninjaTodo

" invalid syntax
syn match ninjaError '#.*$' contained

" define syntax name
let b:current_syntax = "ninja"

" link syntax groups to standard colours
hi def link ninjaTodo           Todo
hi def link ninjaComment        Comment
hi def link ninjaDescriptor     Statement
hi def link ninjaArgument       Type
hi def link ninjaVariable       Identifier
hi def link ninjaFlavor         Constant
hi def link ninjaError          Error
