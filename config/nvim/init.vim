" Because of my terminal disable cursor shape -> weird artifacts else!!!
set guicursor=
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Managing Plugins with VimPlug!!!
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.local/share/nvim/plugged')

" Airline
Plug 'bling/vim-airline' "StatusBar not dependend on Python
Plug 'vim-airline/vim-airline-themes' "Airline themes are moved to here

" Colorscheme
Plug 'nanotech/jellybeans.vim'
Plug 'dracula/vim', {'as': 'dracula'}

" File-Browsing etc.
Plug 'scrooloose/nerdtree' "File explorer
Plug 'kien/ctrlp.vim'      "Fuzzy file finder

" NeoMake
Plug 'neomake/neomake'

" vim-test
Plug 'janko-m/vim-test'

" Input
Plug 'tpope/vim-surround' "fancy surrounding options
Plug 'tomtom/tcomment_vim' "Commenting out with only one stroke
Plug 'tpope/vim-endwise' "Closing def, if, ...
Plug 'tpope/vim-ragtag' "Tools for Tags...
Plug 'Townk/vim-autoclose' "For closing parenthesis
" Plug 'ervandew/supertab' "Tab completion
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

" HTML
Plug 'othree/html5.vim' "Autocomplete for HTML5
Plug 'mattn/emmet-vim'

" Autocompletion
Plug 'Shougo/deoplete.nvim'
Plug 'carlitux/deoplete-ternjs' "JS

" JS
Plug 'w0rp/ale'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue'] }

" Elixir and Phoenix
Plug 'sheerun/vim-polyglot'
Plug 'ludovicchabant/vim-gutentags'
Plug 'slashmili/alchemist.vim'
Plug 'c-brenn/phoenix.vim'
Plug 'tpope/vim-projectionist'
 
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

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ##### My Configurations! ######
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
set updatetime=400
autocmd BufRead,BufNewFile * setlocal signcolumn=yes
autocmd BufEnter NERD_tree_* setlocal signcolumn=no

" Disable stupid backup and swap files - they trigger too many events
" for file system watchers
 set nobackup
 set nowritebackup
 set noswapfile

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

 set colorcolumn=81
 highlight ColorColumn ctermbg=2

 colorscheme dracula

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

" Automatic reloading of .vimrc
autocmd! bufwritepost ~/.config/nvim/init.vim source %

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Key-Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" For my own health - get rid of ESC 
imap kj <ESC>
tnoremap <Esc> <C-\><C-n>
tnoremap kj  <C-\><C-n>

" Rebind <Leader> key
 let mapleader = ","
 
" Better copy & paste
" When you want to paste large blocks of code into vim, press F2 before you
" paste. At the bottom you should see ``-- INSERT (paste) --``.
set pastetoggle=<F2>
vmap <C-x> :!pbcopy<CR>
vmap <C-c> :w !pbcopy<CR><CR>

" Mouse and backspace
 set mouse=a  " on OSX press ALT and click

" Bind nohl
" Removes highlight of your last search
" ``<C>`` stands for ``CTRL`` and therefore ``<C-n>`` stands for ``CTRL+n``
 noremap <C-n> :nohl<CR>
 vnoremap <C-n> :nohl<CR>

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

" Search and Replace word under cursor
 nnoremap <Leader>F :%s/<C-r><C-w>//g<Left><Left>

" Generate/Create ctags file
 nnoremap <Leader>ct :!ctags -a -R -u<CR>

" bind Ctrl+<movement> keys to move around the windows, instead of using Ctrl+w + <movement>
 map <c-j> <c-w>j
 map <c-k> <c-w>k
 map <c-l> <c-w>l
 map <c-h> <c-w>h
 
" easier handling of buffers and tabs
set hidden
set confirm
map <Leader>l :ls<CR>:buffer<Space>
map <Leader>v :ls<CR>:vert sb<Space>
map <Leader>d :ls<CR>:bd!<Space>
map <Leader>D :w<CR>:bd!<CR>
map <C-A-x> :bn<CR>
map <C-A-y> :bp<CR>
map <C-A-z> :tabnew %<CR>
map <Leader>m :tabn<CR>
map <Leader>n :tabp<CR>
map <C-A-S-b> :vert sball<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" #### AIRLINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" I want airline directly - not just after a split
set laststatus=2
" theme & font
let g:airline_theme='luna'
let g:airline_powerline_fonts=0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" #### Deoplede
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:deoplete#enable_at_startup = 0
call deoplete#custom#option({
      \ 'auto_complete_delay': 100,
      \})
autocmd InsertEnter * call deoplete#enable()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" #### NERDTree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <C-A-a> :NERDTreeToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" #### Vim-Test
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:test#strategy='neovim'
let g:test#preserve_screen = 1

" Bindings for vim-test
nmap <silent> <Leader>tn :TestNearest<CR>
nmap <silent> <Leader>ts :TestFile<CR>
nmap <silent> <Leader>ta :TestSuite<CR>
nmap <silent> <Leader>tl :TestLast<CR>
nmap <silent> <Leader>tv :TestVisit<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" #### NeoMake config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call neomake#configure#automake('w')

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" #### Emmet 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:user_emmet_leader_key='<Tab>'
let g:user_emmet_settings = {
  \ 'javascript.jsx' : {
    \ 'extends' : 'jsx',
    \ },
  \ }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" #### Rails
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" map vim-rails :Rake to shortcut
map <Leader>r :Rake<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" #### Git 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" get easy in the Gstatus-window of fugitive
 nnoremap <Leader>gs :Gstatus<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" #### Ctags
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gutentags_cache_dir = '~/.tags_cache'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"    ##### JavaScript #####
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"### Linting with ale
" ALE
let g:ale_lint_on_enter=0
let g:set_highlights=0
let g:ale_completion_enabled=1
let g:ale_keep_list_window_open=1
let g:ale_lint_on_text_changed='never'
highlight ALEWarning ctermbg=DarkMagenta

" ### Prettier
let g:prettier#autoformat = 0
" Do not run Prettier for every save - rather manually with Leader-P.
" autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync

"### Autocompletion with ternjs
" Whether to include the types of the completions in the result data. Default: 0
let g:deoplete#sources#ternjs#types = 1

" Whether to include the distance (in scopes for variables, in prototypes for 
" properties) between the completions and the origin position in the result 
" data. Default: 0
let g:deoplete#sources#ternjs#depths = 1

" Whether to include documentation strings (if found) in the result data.
let g:deoplete#sources#ternjs#docs = 1

" When on, only completions that match the current word at the given point will
" be returned. Turn this off to get all results, so that you can filter on the 
" client side. Default: 1
let g:deoplete#sources#ternjs#filter = 0
let g:deoplete#sources#ternjs#case_insensitive = 1
let g:deoplete#sources#ternjs#guess = 0
let g:deoplete#sources#ternjs#sort = 0
let g:deoplete#sources#ternjs#expand_word_forward = 0
let g:deoplete#sources#ternjs#omit_object_prototype = 0
let g:deoplete#sources#ternjs#include_keywords = 1
let g:deoplete#sources#ternjs#in_literal = 0

"Add extra filetypes
let g:deoplete#sources#ternjs#filetypes = [
                \ 'jsx',
                \ 'javascript.jsx',
                \ 'vue',
                \ '...'
                \ ]

" Other configurations
source ~/.config/nvim/projectionist_heuristics.vim
source ~/.config/nvim/myMacros.vim
