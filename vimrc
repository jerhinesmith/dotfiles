" Choose no compatibility with legacy vi
set nocompatible

" Set the colorscheme
colorscheme wombat

" Turn on syntax highlighting
syntax enable

" Map escape to `;;`
imap ;; <Esc>

" Always show numbered lines
set number

"" Whitespace
set nowrap                        " Don't wrap lines
set tabstop=2                     " Set tabs as 2 spaces
set softtabstop=2
set shiftwidth=2
set expandtab                     " Use spaces instead of tabs
set backspace=indent,eol,start    " Backspace through everything in insert mode

"" Search
set hlsearch                      " Highlight matches
set incsearch                     " Incremental searching
set ignorecase                    " Searches are case insensitive...
set smartcase                     " ... unless they contain at least one capital letter

" Don't display warning for hidden buffers
set hidden

" Map moving windows to the ctrl counter parts
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
