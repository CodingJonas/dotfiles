syntax on
let mapleader = "\<Space>"
set background=dark
" colorscheme gruvbox

""""""""""""""""""""""""""""""""""""""""
"""""""""""" GENERAL SETTINGS""""""""""""
"""""""""""""""""""""""""""""""""""""""""
" Handle tpp as cpp
autocmd BufEnter *.tpp :setlocal filetype=cpp

" Save automatically when leaving a buffer
au BufLeave * silent! wall

" Delete all empty lines in the end
autocmd BufWritePre * :%s/\s\+$//e

" Autosave if focus lost, only supported in terminal version
au FocusLost * :wa

" restore_view needs this
set viewoptions=cursor,folds,slash,unix

set timeoutlen=300

" For smooth scrolling
set so=5

" Show last command
set showcmd

" Show wildmenu TODO: do I want more settings for this?
set wildmenu

" Activate line numbers
set ruler
set nu
set relativenumber

"brace face
set showmatch
set matchtime=3

" More responsive split
set splitbelow
set splitright

" Resize splits when the window is resized
au VimResized * :wincmd =

" change directory when entering file
set autochdir

" Use spaces instead of tabs
set expandtab

" Better intendation
set autoindent
set smarttab
set tabstop=4
set shiftwidth=4

" Searching
set incsearch
set hlsearch
set ignorecase
set smartcase

" Replacing
set gdefault

" vi sucks
set nocompatible

" Improve undo tasks
set history=1000
set undofile
set undodir=~/.vim/undo
set undolevels=2000
set undoreload=10000

" Save swap and backup files neatly at one place
set backupdir=~/.vim/backup

" Highlight the 80th column
"highlight ColorColumn guibg=gray15
"let &colorcolumn="80"

let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

""""""""""""""KEY MAPPINGS"""""""""""""""
"""""""""""""""""""""""""""""""""""""""""

" noremap <leader>T :! sh /home/jonas/scripts/ctags_with_dep.sh %:p:h/*.hpp %:p:h/*cpp<cr>

inoremap jk <esc>

" Jump easy to beginning/start of line
noremap H ^
noremap L $

nnoremap <cr> :w<cr>

" Give arrow keys a better purpose
noremap <down> ddp
noremap <up> ddkP
vnoremap <down> dp
vnoremap <down> dkP

" Folding
setlocal foldmethod=syntax
nnoremap < za
nnoremap > zA
nnoremap <leader>< zM
nnoremap <leader>> zR
autocmd FileType gitcommit setlocal nofoldenable

" more convenient way to use markers
noremap 'a `a
noremap `a 'a
noremap 'b `b
noremap ``b 'b
noremap '. `a
noremap `` ''

" Stop highlighting
nnoremap <esc> :noh<return><esc>

" For split selection
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" go easily through the loclist
nnoremap <leader>K :lprevious<cr>
nnoremap <leader>J :lnext<cr>

" Double space opens last file again
noremap <leader><leader> :w<CR>:e#<CR>

" Close window
nnoremap <leader>q :q<cr>
" Close terminal mode
:tnoremap <Esc> <C-\><C-n>

" Copy&paste
nnoremap <leader>p "+p
vnoremap <leader>y "+y

" Replace a word witht the earlier yanked text
" Won't delete the yanked word from the buffer
xnoremap p "_dP

" Quickly change to global replace mode
nnoremap <leader>r :%s/

" Quick lines
nnoremap <leader>o o<esc>^Dk
nnoremap <leader>O O<esc>^Dj

" mapping to make movements operate on 1 screen line in wrap mode
function! ScreenMovement(movement)
    if &wrap
        return "g" . a:movement
    else
        return a:movement
    endif
endfunction

" Scrolling always fucks up my code
set mouse=a

" Use # as comment string in cmake files
autocmd FileType cmake setl cms=#%s

onoremap <silent> <expr> j ScreenMovement("j")
onoremap <silent> <expr> k ScreenMovement("k")
onoremap <silent> <expr> 0 ScreenMovement("0")
onoremap <silent> <expr> ^ ScreenMovement("^")
onoremap <silent> <expr> $ ScreenMovement("$")
nnoremap <silent> <expr> j ScreenMovement("j")
nnoremap <silent> <expr> k ScreenMovement("k")
nnoremap <silent> <expr> 0 ScreenMovement("0")
nnoremap <silent> <expr> ^ ScreenMovement("^")
nnoremap <silent> <expr> $ ScreenMovement("$")
