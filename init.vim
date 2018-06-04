" Because of my terminal disable cursor shape -> weird artifacts else!!!
set guicursor=

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Managing Plugins with VimPlug!!!
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.local/share/nvim/plugged')

" Airline
Plug 'bling/vim-airline' "StatusBar not dependend on Python
Plug 'vim-airline/vim-airline-themes' "Airline themes are moved to here

" File-Browsing etc.
Plug 'scrooloose/nerdtree' "File explorer
Plug 'kien/ctrlp.vim'      "Fuzzy file finder

" NeoMake
Plug 'neomake/neomake'

" Autocompletion with Deoplede
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Input
Plug 'tpope/vim-surround' "fancy surrounding options
Plug 'tomtom/tcomment_vim' "Commenting out with only one stroke
Plug 'tpope/vim-endwise' "Closing def, if, ...
Plug 'tpope/vim-ragtag' "Tools for Tags...
Plug 'Townk/vim-autoclose' "For closing parenthesis
Plug 'ervandew/supertab' "Tab completion
Plug 'dhruvasagar/vim-table-mode' "create tables with vim

" Ruby and Rails
Plug 'tpope/vim-rails' "Rails Powertool
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' } "Tools for Ruby
Plug 'tpope/vim-bundler', { 'for': 'ruby' } "Hooks into bundler
Plug 'kchmck/vim-coffee-script' "Vim Script for Coffee-Script
Plug 'keith/rspec.vim', { 'for': 'ruby' } "Highlighting RSpec
Plug 'thoughtbot/vim-rspec', { 'for': 'ruby' } "Fire RSpecs out of Vim with one keystroke
Plug 'tpope/vim-haml' "HAML support
Plug 'tpope/vim-cucumber' "Cucumber support

" HTML and JavaScript
Plug 'othree/html5.vim' "Autocomplete for HTML5
Plug 'claco/jasmine.vim'   "Highlighting for jasmine.js

" Git
Plug 'tpope/vim-fugitive' "Controle Git
Plug 'airblade/vim-gitgutter'

" more...
Plug 'tpope/vim-dispatch' "run asynchonous commands
Plug 'itchyny/calendar.vim' "Calender for Vim
Plug 'hsitz/VimOrganizer' "Org-Mode for Vim

""" Vim as a C++ IDE
Plug 'jalcine/cmake.vim', { 'for': 'cpp' } "CMake from vim 
Plug 'alepez/vim-gtest', { 'for': 'cpp' } "GTest commands
" Plug 'Valloric/YouCompleteMe' "Clang based autocompletion
" Plugin 'vim-scripts/Conque-GDB' "Debug from within vim <=== UNCOMMENT this line for debugging with GDB!

" Vim as LaTeX-IDE
Plug 'ying17zi/vim-live-latex-preview', { 'for': 'tex' }
Plug 'brennier/quicktex', { 'for': 'tex' }

""" OLD and not used due to NEOvim
" Plug 'mattn/emmet-vim' "Emmet for HTML and CSS - from github
" Plug 'jgdavey/tslime.vim' "Send specs to another tmux window
""" vim snipmate & dependencies
" Plug 'MarcWeber/vim-addon-mw-utils'
" Plug 'tomtom/tlib_vim'
" Plug 'honza/vim-snippets'
" Plug 'garbas/vim-snipmate'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" My Configurations!
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax on
set updatetime=400
autocmd BufRead,BufNewFile * setlocal signcolumn=yes
autocmd BufEnter NERD_tree_* setlocal signcolumn=no

" Enable Deoplete
let g:deoplete#enable_at_startup = 1
 
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
map <C-A-l> :NERDTreeToggle<CR>

" For my own health - get rid of ESC 
imap jj <ESC>
tnoremap <Esc> <C-\><C-n>
tnoremap jj  <C-\><C-n>

" Automatic reloading of .vimrc
autocmd! bufwritepost /home/schmitze/.config/nvim/init.vim source %

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

" NeoMake config
call neomake#configure#automake('w')

" settings for rspec-vim and tslime
" let g:rspec_command = 'call Send_to_Tmux("rspec {spec}\n")'

" map <Leader>t :call RunCurrentSpecFile()<CR>
" map <Leader>s :call RunNearestSpec()<CR>
" map <Leader>l :call RunLastSpec()<CR>
" map <Leader>a :call RunAllSpecs()<CR>

" map vim-rails :Rake to shortcut
map <Leader>r :Rake<CR>

" get easy in the Gstatus-window of fugitive
 nnoremap <Leader>gs :Gstatus<CR>

" easier moving between buffers and tabs
"  map <Leader>n <esc>:bn<CR>
"  map <Leader>m <esc>:bp<CR>
set hidden
set confirm
map <A-l> :ls<CR>:buffer<Space>
map <A-v> :ls<CR>:vert sb<Space>
map <A-d> :ls<CR>:bd<Space>
map <A-n> :bn<CR>
map <A-m> :bp<CR>
map <C-A-z> :tabnew %<CR>
map <Leader>m :tabn<CR>
map <Leader>n :tabp<CR>
map <C-A-S-b> :vert sball<CR>

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

 colorscheme darkblue

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
 set hlsearch
 set incsearch
 set ignorecase
 set smartcase


" Disable stupid backup and swap files - they trigger too many events
" for file system watchers
 set nobackup
 set nowritebackup
 set noswapfile

" Some settings for the vim org-mode clone -> VimOrganizer
" au! BufRead,BufWrite,BufWritePost,BufNewFile *.org
" au BufEnter *.org call org#SetOrgFileType()

" Some macros for the work with rails
" changing a spec line callin get, post, ... to new params hash syntax
let @a = '0f,a params: {lxA }'
" change old to new hash syntax when placed over the leading :
let @s = 'xeplxxx'
" changes a member variable declaration to a specs let(..)
let @d = '0f@xilet(:ea)f=r{A }'
