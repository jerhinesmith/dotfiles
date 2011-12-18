" Set the colorscheme
" colorscheme blackboard

" Turn on syntax highlighting
sy on

" Map escape to `;;`
imap ;; <Esc>

" Always show numbered lines
set number

" Shortcut to raipidly toggle `set list`
nmap <leader>l :set list!<CR>

" Use the same symbols as TextMate for tabstops and EOLs
" set listchar=tab:▸\,eol:¬

" Control tabbing
set expandtab
filetype indent on
set autoindent
set tabstop=2
set shiftwidth=2
imap <S-Tab> <C-o><<

" Case insensitive search
set ic

" Highlight search
set hls

" Don't display warning for hidden buffers
set hidden

" Map moving windows to the ctrl counter parts
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
