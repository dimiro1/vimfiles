try
  source $REAL_HOME/.vimrc
catch /E484/
endtry

runtime debian.vim

set nocompatible    " We're running Vim, not Vi!

"======================== Indenting ==================================
set ai " Automatically set the indent of a new line (local to buffer)
set si " smartindent  (local to buffer)

"====================== Cursor Highlight =============================
" set cursorline      " Highlight cursor line

"====================== Search =======================================
set hlsearch    " highlight search
set incsearch   " incremental search, search as you type
set ignorecase  " Ignore case when searching
set smartcase   " Ignore case when searching lowercase

"======================= Plugin TOhtml ==============================
let html_use_css = 1 " Use css by default

"====================== Colors =======================================
if has("gui_running")
    set lines=40        " start window with 40 lines
    set columns=115     " start window with 115 columns
    colorscheme wombat
else
    set t_Co=256        " 256 color Terminal
    let g:CSApprox_loaded = 0 " Algorithm to try close the gui-colorschme in terminal
    colorscheme railscasts
endif

if !exists("syntax_on")
    syntax on " Enable Syntax highlighting
endif

"====================== GUI Only =====================================
" this is like gvimrc, i have too litle gui configurations.
" so I prefered put here.

if has("gui_running")
    set guifont=Droid\ Sans\ Mono\ 11     " Font configuration
    set guioptions-=m                     " Disable the menu bar
    set guioptions-=T                     " Disable the toolbar
    set mousehide                         " Hide mouse after chars typed
    " set ch=2		                      " Make command line two lines high
endif

"====================== Status Line ==================================
set showcmd
set ruler           " Show ruler
"set statusline=%<%f\ %h%m%r%=%-20.(line=%l,col=%c%V,totlin=%L%)\%h%m%r%=%-40(,%n%Y%)\%P
set laststatus=2    " status bar with two lines

"====================== Line wrapping ================================
set nowrap          " wrap!
set linebreak       " Wrap at word

"====================== Indenting =====================================
set sw=4            " identation now takes just 4 spaces at a time
set backspace=2     " allow backspacing over everything in insert mode
set shiftwidth=4    " numbers of spaces to (auto)indent

"========================== Mappings ==================================
map ,y "*y
map ,p "*p

" reload vimrc
nnoremap <F12> :source $HOME/.vimrc<BAR> echo "reloaded vimrc!"<CR>

"======================== File stuff ==============================
filetype on         " Enable filetype detection
filetype indent on  " Enable filetype-specific indenting
filetype plugin on  " Enable filetype-specific plugins

"======================= Misc =====================================
set history=1000            " keep 1000 lines of command line history
set nosol                   " cursor is kept in the same column (if possible)
set sm                      " show matching braces, somewhat annoying...
set number                  " show line numbers
set nobackup                " do not keep a backup file
set title                   " show title in console title bar
set ttyfast                 " smoother changes
set tabstop=4               " Set a tab to 4 spaces
set scrolloff=10            " keep 10 lines when scrolling
set clipboard+="unnamed"    " the register "* is set by default
set mouse=a                 " In many terminal emulators the mouse works

"========================= Tab key ====================================
set expandtab                       " tabs are converted to spaces
vnoremap < <gv                      " unindent a block of code visualy
vnoremap > >gv                      " indent a block of code visualy
set wildmode=list:longest           " make cmdline tab completion similar to bash
set wildmenu                        " enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~,*.swp   " stuff to ignore when tab completing


"======================== Omni Completion ==========================
" Allow autocompletions
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete " may require ruby compiled in



"========================= Load Plugins ============================
let loaded_vimspell = 1

" For all text files set 'textwidth' to 78 characters
autocmd FileType text setlocal textwidth=78             
autocmd Filetype ruby source $HOME/.vim/ruby-macros.vim

"======================== Completions ==============================
" To don't type wrong
iab linux GNU/Linux
iab Linux GNU/Linux

"======================== Functions ================================

" Convert dos file to unix
function! Dos2Unix()
    try
        exec '%s/\%x0d//g'
    catch
        echo v:exception
    endtry
endfunction

" Returns the filename
function! Filename()
    return expand("%:t:r")
endfunction

"====================== Commands ===================================

command! -nargs=0 Dos2Unix call Dos2Unix()      " Call Dos2Unix function

command! -nargs=0 Vimrc :e $HOME/.vimrc         " Open vimrc file for editing
command! -nargs=0 GVimrc :e $HOME/.gvimrc       " Open gvimrc file for editing
command! -nargs=0 RVimrc :source $HOME/.vimrc   " Reload Vimrc
command! -nargs=0 RGVimrc :source $HOME/.gvimrc " Reload Gvimrc

"define :Lorem command to dump in a paragraph of lorem ipsum
command! -nargs=0 Lorem :normal iLorem ipsum dolor sit amet, consectetur
      \ adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore
      \ magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation
      \ ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute
      \ irure dolor in reprehenderit in voluptate velit esse cillum dolore eu
      \ fugiat nulla pariatur.  Excepteur sint occaecat cupidatat non
      \ proident, sunt in culpa qui officia deserunt mollit anim id est
      \ laborum

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\   exe "normal! g`\"" |
\ endif

