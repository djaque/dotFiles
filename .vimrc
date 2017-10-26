:set ai
:set nowrap
:set wildmode=longest,list,full
:set wildmenu
:com W w
:com Wa wa
:set splitbelow
:set splitright
:set list
:set cursorline
:set noswapfile
":se cursorline
":hi CursorLine term=none cterm=none ctermbg=4
":autocmd InsertLeave * hi CursorLine term=none cterm=none ctermbg=4
":autocmd InsertEnter * hi CursorLine term=none cterm=none ctermbg=8
:au BufRead,BufNewFile *.phpt set filetype=php
:autocmd FileType * set tabstop=4|set shiftwidth=4|set smartindent|set smarttab|set noexpandtab
:autocmd FileType python set tabstop=4|set shiftwidth=4|set smartindent|set smarttab|set expandtab
:autocmd FileType php set tabstop=4|set shiftwidth=4|set smartindent|set smarttab|set expandtab|highlight OverLength ctermbg=red ctermfg=white guibg=#592929|match OverLength /\%121v.\+/
:autocmd FileType sql set tabstop=4|set shiftwidth=4|set smartindent|set smarttab|set expandtab|highlight OverLength ctermbg=red ctermfg=white guibg=#592929|match OverLength /\%321v.\+/
:autocmd FileType javascript set tabstop=2|set shiftwidth=2|set smartindent|set smarttab|set expandtab
:nmap Q :echo "Q"<CR>
:com Chtab set noet ci pi sts=0 sw=4 ts=4
:colorscheme molokai
":colorscheme desert
execute pathogen#infect()
syntax on
filetype plugin indent on

highlight Comment cterm=bold
set encoding=iso-8859-1
set fileencoding=iso-8859-1
