:set ai
:set nowrap
:set wildmode=longest,list,full
:set wildmenu
:com W w
:com Wa wa
:set splitbelow
:set splitright

:set cursorline
:set noswapfile
":se cursorline
":hi CursorLine term=none cterm=none ctermbg=4
":autocmd InsertLeave * hi CursorLine term=none cterm=none ctermbg=4
":autocmd InsertEnter * hi CursorLine term=none cterm=none ctermbg=8
:autocmd FileType * set tabstop=4|set shiftwidth=4|set smartindent|set smarttab|set noexpandtab
:autocmd FileType python set tabstop=4|set shiftwidth=4|set smartindent|set smarttab|set expandtab
:autocmd FileType javascript set tabstop=4|set shiftwidth=4|set smartindent|set smarttab|set expandtab
:nmap Q :echo "Q"<CR>
":colorscheme desert
execute pathogen#infect()
syntax on
filetype plugin indent on

colorscheme molokai
highlight Comment cterm=bold
