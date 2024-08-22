" Basic Vimrc Configuration
" =========================

" Set line numbers
set number

" Enable syntax highlighting
syntax on

" Set relative line numbers
set relativenumber

" Enable mouse support in all modes
set mouse=a

" Set tabs and indentation
set tabstop=4           " Number of spaces that a <Tab> in the file counts for
set shiftwidth=4        " Number of spaces to use for each step of (auto)indent
set expandtab           " Use spaces instead of tabs
set autoindent          " Copy indent from current line when starting a new line
set smartindent         " Do smart indenting on new lines

" Enable auto-completion for words in the current buffer
set wildmenu
set wildmode=longest:full,full

" Allow backspace over everything in insert mode
set backspace=indent,eol,start

" Enable incremental search
set incsearch

" Highlight search results
set hlsearch

" Case-insensitive search unless capitalized
set ignorecase
set smartcase

" Enable persistent undo so undo history is saved across sessions
set undofile
set undodir=~/.vim/undodir

" Show matching parentheses, brackets, etc.
set showmatch

" Status line customization
set laststatus=2
set ruler

" Enable clipboard to use system clipboard
set clipboard=unnamedplus

" Faster redraw time
set lazyredraw

" Use spaces instead of tabs
set expandtab

" Display command in the status line
set showcmd

" Use visual bell instead of beeping
" set visualbell

" Set split window behavior
set splitbelow   " Open new horizontal splits below the current window
set splitright   " Open new vertical splits to the right of the current window

" Enable file type detection and plugin support
filetype plugin indent on

" Auto-read files changed outside of Vim
set autoread

" Set up some basic mappings
nnoremap <C-s> :w<CR>     " Save file with Ctrl + s
nnoremap <C-q> :q<CR>     " Quit Vim with Ctrl + q

" Set a vertical line at 80 characters
set colorcolumn=80
highlight ColorColumn ctermbg=lightgrey guibg=lightgrey

" Open the Vim cheat sheet in a vertical split
autocmd VimEnter * execute "vsplit ~/.vim/vim_cheat_sheet.txt" | wincmd h

" Plugins can be added below (if using a plugin manager like vim-plug or Vundle)
" e.g., Plug 'tpope/vim-sensible'

"Plug 'tomasiser/vim-code-dark'
if filereadable(expand("~/.vimrc.plug"))
    source ~/.vimrc.plug
endif

" Set color scheme
colorscheme codedark

" End of vimrc

