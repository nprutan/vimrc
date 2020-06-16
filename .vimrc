syntax on

set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set colorcolumn=88
highlight ColorColumn ctermbg=0 guibg=lightgrey

:set number relativenumber

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

call plug#begin('~/.vim/plugged')

Plug 'ycm-core/YouCompleteMe'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'janko/vim-test'
Plug 'wakatime/vim-wakatime'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'dense-analysis/ale'
Plug 'Chiel92/vim-autoformat'

call plug#end()

colorscheme gruvbox
set background=dark

if executable('rg')
    let g:rg_derive_root='true'
endif

let mapleader = " "

let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25

let g:ycm_language_server =
\ [
\   {
\     'name': 'rust',
\     'cmdline': ['rust-analyzer'],
\     'filetypes': ['rust'],
\     'project_root_files': ['Cargo.toml']
\   }
\ ]

" make test commands execute using dispatch.vim
let test#strategy = "vimterminal"

" Ale
let g:ale_lint_on_enter = 0
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" Check Python files with flake8 and pylint.
let g:ale_linters = {
\   'python': ['flake8'],
\}
" Fix Python files with autopep8 and yapf.
let g:ale_fixers =  {
\   'javascript': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['black', 'isort']
\}
" Disable warnings about trailing whitespace for Python files.
let g:ale_warn_about_trailing_whitespace = 0

" Airline
let g:airline_left_sep  = ''
let g:airline_right_sep = ''
let g:airline#extensions#ale#enabled = 1
let airline#extensions#ale#error_symbol = 'E:'
let airline#extensions#ale#warning_symbol = 'W:'

" Autoformat
let g:formatters_python = ['black']

nnoremap <leader>h :wincmd h<CR>
noremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <Leader>ps :Rg<SPACE>
nnoremap <silent> <Leader>+ :vertical resize +5<CR>
nnoremap <silent> <Leader>- :vertical resize -5<CR>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nmap <C-n> :NERDTreeToggle<CR>
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>tn :w <Esc>:TestNearest<CR>
nnoremap <leader>ta :w <Esc>:TestSuite<CR>
nnoremap <leader>tl :w <Esc>:TestLast<CR>
nnoremap <leader>gd :YcmCompleter GoTo<CR>
nnoremap <leader>gr :YcmCompleter GoToReferences<CR>
nnoremap <leader>rr :YcmCompleter RefactorRename<space>

" fun! GoYCM()
"    nnoremap <buffer> <silent> <leader>gd :YcmCompleter GoTo<CR>
"    nnoremap <buffer> <silent> <leader>gr :YcmCompleter GoToReferences<CR>
"    nnoremap <buffer> <silent> <leader>rr :YcmCompleter RefactorRename<space>
" endfun

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

" autocmd BufWritePre * :call TrimWhitespace()
" autocmd FileType .py call GoYCM()
