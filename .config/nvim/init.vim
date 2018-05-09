syntax on
let mapleader = "\<Space>"

"""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""PLUGINS"""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.local/share/nvim/plugged')

" File Browser
Plug 'scrooloose/nerdtree'

" Commenter
Plug 'tpope/vim-commentary'

" Restore view after opening a file
Plug 'vim-scripts/restore_view.vim'

" Easy extending of selections
" Plug 'terryma/vim-expand-region'

" Swap windows easily
Plug 'wesQ3/vim-windowswap'

" Open/Close pairs automatically
Plug 'jiangmiao/auto-pairs'

" Auto-formatting for C/C++, experimental to load always except for python
Plug 'rhysd/vim-clang-format', has('python') ? { 'on': [] } : {}
" Plug 'rhysd/vim-clang-format', {'for': ['c', 'cpp']}

" Complete IDE suit for python
" Plug 'davidhalter/jedi-vim', {'for': 'python'}
" Plug 'zchee/deoplete-jedi'

" Auto-formatting for python
Plug 'tell-k/vim-autopep8', {'for': 'python'}

" Auto-complete
Plug 'Shougo/deoplete.nvim'
Plug 'Shougo/neoinclude.vim'
Plug 'zchee/deoplete-jedi'
" Plug 'LuXuryPro/deoplete-rtags'

" Show function signature from autocompletion TODO: not working currently
Plug 'Shougo/echodoc.vim'

" Improve status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Syntax checking
" Plug 'vim-syntastic/syntastic'
" Plug 'w0rp/ale'

" Change background of hex colors to what they define
Plug 'chrisbra/Colorizer'

" Generate Doxygen comments
Plug 'vim-scripts/DoxygenToolkit.vim'

" Visualize git commits and status
Plug 'jreybert/vimagit'

" jump easier to other words
Plug 'unblevable/quick-scope'

" Play games
Plug 'johngrib/vim-game-code-break'
Plug 'johngrib/vim-game-snake'

" Color scheme
Plug 'rakr/vim-one'
Plug 'dylanaraps/wal.vim'

" For taking notes
Plug 'vimwiki/vimwiki'

call plug#end()
filetype plugin indent on

"""""""""""""""""""""""""""""""""""""""""
"""""""""""PLUGIN KEY MAPPINGS"""""""""""
"""""""""""""""""""""""""""""""""""""""""

set background=dark
colorscheme gruvbox
" colorscheme mayansmoke
" colorscheme github
" wal colorscheme is created by the program wal
" colorscheme wal


"""""" NERDTREE
nnoremap <leader>t :NERDTreeToggle<CR>
autocmd BufEnter * lcd %:p:h
"close vim if the only window left is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" close nerdtree when opening a new window
let g:NERDTreeQuitOnOpen=1


"""""" commentary
nmap <leader>c gc
nmap <leader>C Ygccp
vmap <leader>c gc
autocmd FileType cpp setlocal commentstring=//\ %s

"""""" vim-expand-region
vmap v <Plug>(expand_region_expand)
vmap <c-v> <Plug>(expand_region_shrink)

"""""" vim-windowswap
let g:windowswap_map_keys = 0 "prevent default bindings
nnoremap <silent> <leader>yw :call WindowSwap#MarkWindowSwap()<CR>
nnoremap <silent> <leader>pw :call WindowSwap#DoWindowSwap()<CR>
nnoremap <silent> <leader>w :call WindowSwap#EasyWindowSwap()<CR>

""""" auto-pair
inoremap {{ {
inoremap }} }
inoremap (( (
inoremap )) )
inoremap "" "
inoremap '' '
inoremap `` `

""""" vim-clang-format
let g:clang_format#detect_style_file = 1
nnoremap <Leader>f :ClangFormat<CR>
vnoremap <Leader>f :ClangFormat<CR>
" Set a marker to jump back to position after formatting
nmap <Leader>F mz:ClangFormatAutoToggle<CR>`z

""""" vim-autopep8
let g:autopep8_max_line_length=120
let g:autopep8_indent_size=4
let g:autopep8_disable_show_diff=1
autocmd FileType python noremap <leader>f mz:Autopep8<CR>`z

""""" deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources = {}
let g:deoplete#sources._ = ['buffer', 'tag', 'file']
let deoplete#tag#cache_limit_size = 5000000
inoremap <silent><expr> <TAB>
		\ pumvisible() ? "\<C-n>" :
		\ <SID>check_back_space() ? "\<TAB>" :
		\ deoplete#mappings#manual_complete()
		function! s:check_back_space() abort "{{{
		let col = col('.') - 1
		return !col || getline('.')[col - 1]  =~ '\s'
		endfunction"}}}
" let g:deoplete#sources#jedi#server_timeout = 1


""""" echodoc
set noshowmode

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
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_error_symbol = "✗"
let g:syntastic_cpp_compiler_options = "-std=c++11 -Wall -Wextra -Wpedantic"

""""" Colorizer
let g:colorizer_x11_names = 1
:let g:colorizer_auto_filetype='css,html'
noremap <leader>CC      :ColorToggle<Cr>

""""" DoxygenToolkit
noremap <leader>D :Dox<Cr>

""""" quick-scope
" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']


""""" vimwiki
:nmap <Leader>we <Plug>VimwikiSplitLink

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

" Change the cursor shape in insert mode
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=2

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
set undodir=~/.config/nvim/undo
set undolevels=2000
set undoreload=10000

" Save swap and backup files neatly at one place
set backupdir=~/.config/nvim/backup

" Highlight the 80th column
"highlight ColorColumn guibg=gray15
"let &colorcolumn="80"


"""""""""""""""""""""""""""""""""""""""""
""""""""""""""KEY MAPPINGS"""""""""""""""
"""""""""""""""""""""""""""""""""""""""""

noremap <leader>T :! sh /home/jonas/scripts/ctags_with_dep.sh %:p:h/*.hpp %:p:h/*cpp<cr>

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

" Execute last command again
noremap <leader>e @:

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

function! GetCurrentColorScheme()
    if !has('gui_running')
        return 'solarized'
    endif
    let l:dayOfWeek = strftime('%a')
    if l:dayOfWeek ==# 'Sat'
        return 'gruvbox'
    endif
    if l:dayOfWeek ==# 'Sun'
        return 'PaperColor'
    endif
    return 'solarized'
endfunction

function! GetCurrentBackground()
    if !has('gui_running')
        return 'dark'
    endif
    return (strftime('%H') > 6 && strftime('%H') < 18) ? 'light' : 'dark'
endfunction

" exec 'set background=' . GetCurrentBackground()
"exec 'colorscheme ' . GetCurrentColorScheme()

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
