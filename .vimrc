""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Managing Plugins with Vundle!!!
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
"""""""""""""""
" My Plugins
"""""""""""""""
Plugin 'tpope/vim-dispatch' "run asynchonous commands
Plugin 'itchyny/calendar.vim' "Calender for Vim
Plugin 'hsitz/VimOrganizer' "Org-Mode for Vim
Plugin 'dhruvasagar/vim-table-mode' "create tables with vim
Plugin 'mattn/emmet-vim' "Emmet for HTML and CSS - from github
Plugin 'bling/vim-airline' "StatusBar not dependend on Python
Plugin 'vim-airline/vim-airline-themes' "Airline themes are moved to here
Plugin 'Townk/vim-autoclose' "For closing parenthesis
Plugin 'scrooloose/nerdtree' "File explorer
Plugin 'kien/ctrlp.vim'      "Fuzzy file finder
Plugin 'othree/html5.vim' "Autocomplete for HTML5
Plugin 'tpope/vim-rails' "Rails Powertool
Plugin 'tpope/vim-fugitive' "Controle Git
Plugin 'vim-ruby/vim-ruby' "Tools for Ruby
Plugin 'tpope/vim-endwise' "Closing def, if, ...
Plugin 'tpope/vim-ragtag' "Tools for Tags...
Plugin 'tomtom/tcomment_vim' "Commenting out with only one stroke
Plugin 'ervandew/supertab' "Tab completion
Plugin 'kchmck/vim-coffee-script' "Vim Script for Coffee-Script
Plugin 'claco/jasmine.vim'   "Highlighting for jasmine.js
Plugin 'keith/rspec.vim' "Highlighting RSpec
Plugin 'thoughtbot/vim-rspec' "Fire RSpecs out of Vim with one keystroke
Plugin 'jgdavey/tslime.vim' "Send specs to another tmux window
Plugin 'tpope/vim-haml' "HAML support
""" vim snipmate & dependencies
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'honza/vim-snippets'
Plugin 'garbas/vim-snipmate'
""" Vim as a C++ IDE
Plugin 'jalcine/cmake.vim' "CMake from vim 
Plugin 'alepez/vim-gtest' "GTest commands


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
syntax on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" My Configurations!
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" AIRLINE
" I want airline directly - not just after a split
set laststatus=2
" theme & font
let g:airline_theme='luna'
let g:airline_powerline_fonts=0

" Rebind <Leader> key
" I like to have it here becuase it is easier to reach than the default and
" it is next to ``m`` and ``n`` which I use for navigating between tabs.
 let mapleader = ","

" NERDTree
" start NERDTree in normal and insert mode with <ctrl>-m
map <Leader>q :NERDTreeFocus<CR>

" For my own health - get rid of ESC 
imap jj <ESC>

" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %


" Better copy & paste
" When you want to paste large blocks of code into vim, press F2 before you
" paste. At the bottom you should see ``-- INSERT (paste) --``.

set pastetoggle=<F2>
" Does not work, because vim was not compiled with clipboard
" set clipboard=unnamed
" to fix this...
vmap <C-x> :!pbcopy<CR>
vmap <C-c> :w !pbcopy<CR><CR>

" Mouse and backspace
 set mouse=a  " on OSX press ALT and click



" Bind nohl
" Removes highlight of your last search
" ``<C>`` stands for ``CTRL`` and therefore ``<C-n>`` stands for ``CTRL+n``
 noremap <C-n> :nohl<CR>
 vnoremap <C-n> :nohl<CR>
" inoremap <C-n> :nohl<CR>


" Quicksave command
 noremap <C-s> :update<CR>
 vnoremap <C-s> <C-C>:update<CR>
 inoremap <C-s> <C-O>:update<CR>


" Quick quit command
 noremap <Leader>e :quit<CR>  " Quit current window
 noremap <Leader>E :qa!<CR>   " Quit all windows
 noremap <silent> <Leader>w :w<CR>     " Write current file
 noremap <Leader>W :wall<CR>  " Write all files
 noremap <Leader>x :x<CR>     " Write & close current file
 noremap <Leader>X :xall<CR>  " Write & close all files


" bind Ctrl+<movement> keys to move around the windows, instead of using Ctrl+w + <movement>
" Every unnecessary keystroke that can be saved is good for your health :)
 map <c-j> <c-w>j
 map <c-k> <c-w>k
 map <c-l> <c-w>l
 map <c-h> <c-w>h

" settings for rspec-vim and tslime
let g:rspec_command = 'call Send_to_Tmux("rspec {spec}\n")'

map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

" map vim-rails :Rake to shortcut
map <Leader>r :Rake<CR>

" get easy in the Gstatus-window of fugitive
 nnoremap <Leader>gs :Gstatus<CR>

" easier moving between tabs
 map <Leader>n <esc>:bn<CR>
 map <Leader>m <esc>:bp<CR>


" map sort function to a key
 vnoremap <Leader>s :sort<CR>


" easier moving of code blocks
" Try to go into visual mode (v), thenselect several lines of code here and
" then press ``>`` several times.
 vnoremap < <gv  " better indentation
 vnoremap > >gv  " better indentation

" Showing line numbers and length
 set number  " show line numbers
 set relativenumber " show line numbers relative to cursor
 set tw=79   " width of document (used by gd)
 set nowrap  " don't automatically wrap on load
 set fo-=t   " don't automatically wrap text when typing
 set cursorline " highlights the actual line
 hi CursorLine cterm=None ctermbg=0 ctermfg=None
 set cursorcolumn   " highlights also active column
 hi CursorColumn cterm=None ctermbg=4 ctermfg=None

 set colorcolumn=100
 highlight ColorColumn ctermbg=5

" easier formatting of paragraphs
"" vmap Q gq
"" nmap Q gqap

" make preview window a size of 20 lines
set previewheight=20

" Useful settings
 set history=700
 set undolevels=700


" Real programmers don't use TABs but spaces
 set tabstop=2
 set softtabstop=2
 set shiftwidth=2
 set shiftround
 set expandtab


" Make search case insensitive
" set hlsearch
 set incsearch
 set ignorecase
 set smartcase


" Disable stupid backup and swap files - they trigger too many events
" for file system watchers
 set nobackup
 set nowritebackup
 set noswapfile

" Some settings for the vim org-mode clone -> VimOrganizer
au! BufRead,BufWrite,BufWritePost,BufNewFile *.org
au BufEnter *.org call org#SetOrgFileType()
