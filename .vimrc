syntax on
let mapleader = "\<Space>"
set background=dark
colorscheme gruvbox


"""""""""""""""""""""""""""""""""""""""""
"""""""""""""""PLUGINS"""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')
" File Browser
Plug 'scrooloose/nerdtree'

" Commenter
Plug 'tpope/vim-commentary'

" Autocomplete
Plug 'Valloric/YouCompleteMe'

" run make async
Plug 'skywind3000/asyncrun.vim'

" Restore view after opening a file
Plug 'vim-scripts/restore_view.vim'

" Swap windows easily
Plug 'wesQ3/vim-windowswap'

" Open/Close pairs automatically
Plug 'jiangmiao/auto-pairs'

" Auto-formatting for python
Plug 'rhysd/vim-clang-format', has('python') ? { 'on': [] } : {}

" Improve status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" vim and tmux
Plug 'christoomey/vim-tmux-navigator'

" Syntax checking
" Plug 'vim-syntastic/syntastic'
" Plug 'w0rp/ale'

" Change background of hex colors to what they define
Plug 'chrisbra/Colorizer'

" Visualize git commits and status
Plug 'jreybert/vimagit'

call plug#end()


"""""""""""""""""""""""""""""""""""""""""
"""""""""""""PLUGIN SETTINGS"""""""""""""
"""""""""""""""""""""""""""""""""""""""""
"""""" NERDTREE
nnoremap <leader>d :NERDTreeToggle<CR>
autocmd BufEnter * lcd %:p:h
"close vim if the only window left is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" close nerdtree when opening a new window
let g:NERDTreeQuitOnOpen=1

"""""" commentary
nmap <leader>c gc
nmap <leader>cy Ygccp
vmap <leader>c gc
autocmd FileType cpp setlocal commentstring=//\ %s

"""""" youcompleteme
let g:ycm_min_num_of_chars_for_completion = 2

""""" asyncRun
augroup vimrc
    autocmd QuickFixCmdPost * botright copen 12
    " autocmd QuickFixCmdPre * let g:mybufname=bufname('%')
    " autocmd QuickFixCmdPost * botright copen 8 | exec bufwinnr(g:mybufname) . 'wincmd w'
augroup END
nnoremap <leader>mm :AsyncRun -cwd=<root> make<CR>
nnoremap <leader>mt :AsyncRun -cwd=<root> make test<CR>
nnoremap <leader>mc :AsyncRun -cwd=<root> make clean<CR>
nnoremap <leader>mr :AsyncRun -cwd=<root> make run<CR>
nnoremap <C-c> :AsyncStop<CR>

" Always use the next Makefile about the current program
let g:asyncrun_rootmarks = ['Makefile', '.svn', '.git', '.root', '.bzr', '_darcs', 'build.xml']
" let g:asyncrun_status = "stopped"
" Show status of make command in vim-airline
" let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])

"""""" vim-windowswap
let g:windowswap_map_keys = 0 "prevent default bindings
nnoremap <silent> <leader>yw :call WindowSwap#MarkWindowSwap()<CR>
nnoremap <silent> <leader>pw :call WindowSwap#DoWindowSwap()<CR>
nnoremap <silent> <leader>w :call WindowSwap#EasyWindowSwap()<CR>

""""" vim-clang-format
let g:clang_format#detect_style_file = 1
nnoremap <Leader>f :ClangFormat<CR>
vnoremap <Leader>f :ClangFormat<CR>
" Set a marker to jump back to position after formatting
nmap <Leader>F mz:ClangFormatAutoToggle<CR>`z


""""" vim airline
let g:airline_powerline_fonts = 1
let g:airline_section_y = {}  "shows the formatting, I don't care about that
let g:airline#extensions#ale#error_symbol="✗ "
let g:airline#extensions#ale#warning_symbol="⚠ "
let g:airline_theme='dark' " or light
let g:powerline_pycmd = "py3"


"""" ale
let g:ale_echo_msg_error_str = '✗'
let g:ale_echo_msg_warning_str = '⚠'
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'
let g:ale_statusline_format = ['✗ %d', '⚠ %d', '⬥ ok']
let g:ale_open_list = 1
" Close vim if the only window left is a quickfix window
autocmd bufenter * if (&buftype == 'quickfix') | q | endif
" I make mistakes constantly. No need to remind me all the time
let g:ale_lint_on_text_changed = 'never'
" Change compiler options for c++
let ale_cpp_clang_options = '-std=c++14 -Wall -Wno-write-strings'

""""" syntasics
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" let g:syntastic_error_symbol = "✗"
" let g:syntastic_cpp_compiler_options = "-std=c++11 -Wall -Wextra -Wpedantic"

""""" Colorizer
let g:colorizer_x11_names = 1
:let g:colorizer_auto_filetype='css,html'
noremap <leader>CC      :ColorToggle<Cr>

"""""""""""""""""""""""""""""""""""""""""
"""""""""""""GENERAL SETTINGS""""""""""""
"""""""""""""""""""""""""""""""""""""""""
" Handle unkown filetypes
autocmd BufEnter,BufNewFile *.tpp :setlocal filetype=cpp
autocmd BufRead,BufNewFile *.njk set filetype=html

" Delete all empty lines in the end
autocmd BufWritePre * :%s/\s\+$//e

" Autosave if focus lost, only supported in terminal version
au BufLeave,FocusLost * :wa

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

" brace face
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
set directory=~/.vim/swapfiles//

" Highlight the 80th column
"highlight ColorColumn guibg=gray15
"let &colorcolumn="80"

let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

" Fix an error with the powerline font
let g:powerline_pycmd="py3"

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
nnoremap <esc>^[ <esc>^[

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
