syntax on
set wildmenu
set wildmode=longest:full,full
set number	" Show line numbers
set linebreak	" Break lines at word (requires Wrap lines)
set showbreak=+++	" Wrap-broken line prefix
set textwidth=100	" Line wrap (number of cols)
set showmatch	" Highlight matching brace
"set spell	" Enable spell-checking
set visualbell	" Use visual bell (no beeping)
 
set hlsearch	" Highlight all search results
set smartcase	" Enable smart-case search
set ignorecase	" Always case-insensitive
set incsearch	" Searches for strings incrementally
 
set autoindent	" Auto-indent new lines
set expandtab	" Use spaces instead of tabs
set shiftwidth=4	" Number of auto-indent spaces
set smartindent	" Enable smart-indent
set smarttab	" Enable smart-tabs
set softtabstop=4	" Number of spaces per Tab
 
"" Advanced
set ruler	" Show row and column ruler information
 
set undolevels=1000	" Number of undo levels
set path+=**
set wildmenu
set nu rnu
command! MakeTags !ctags -R
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
call plug#begin('/home/henry/.config/nvim/plugged')
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
call plug#end()
colorscheme gruvbox
