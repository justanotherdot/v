" file: .config/nvim/init.vim
" author: Ryan James Spencer

call plug#begin('~/.local/share/nvim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'atelierbram/Base2Tone-vim'
Plug 'fatih/vim-go'
Plug 'floobits/floobits-neovim'
Plug 'godlygeek/tabular'
Plug 'idris-hackers/idris-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'kamwitsta/flatwhite-vim'
Plug 'neomake/neomake'
Plug 'ntpeters/vim-better-whitespace'
Plug 'scrooloose/nerdcommenter'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()


colo Base2Tone_PoolDark

set clipboard=unnamedplus " System clipboard.
set cmdheight=1
set expandtab
set formatoptions-=o
set grepprg=rg\ --vimgrep
set hidden
set inccommand=nosplit
set mouse=a
set nofoldenable
set nojoinspaces
set nowrap
set ruler
set shiftwidth=2
set shortmess+=A
set softtabstop=2
set tabstop=2
set termguicolors
set updatetime=100
set visualbell
set wildignore+=*\\tmp\\*,*.swp,*.swo,*.zip,.git,.cabal-sandbox
set wildignorecase
set wildmenu
set wildmode=longest,list,full

let $COLORTERM = 'gnome-terminal' "Fix scrolling issues with nvim and gnome-terminal.
let g:airline#extensions#cursormode#enabled = 0 "Don't let airline mess up the cursor color
let g:airline_theme='Base2Tone_PoolDark'
let g:haskell_enable_quantification = 1
let g:haskell_indent_disable = 1
let g:netrw_banner = 0
let mapleader = ','
let g:fzf_colors =
 \ { 'fg':      ['fg', 'Normal'],
   \ 'bg':      ['bg', 'Normal'],
   \ 'hl':      ['fg', 'Comment'],
   \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
   \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
   \ 'hl+':     ['fg', 'Statement'],
   \ 'info':    ['fg', 'PreProc'],
   \ 'prompt':  ['fg', 'Conditional'],
   \ 'pointer': ['fg', 'Exception'],
   \ 'marker':  ['fg', 'Keyword'],
   \ 'spinner': ['fg', 'Label'],
   \ 'header':  ['fg', 'Comment'] }

cnoremap w!! w !sudo tee > /dev/null %
nnoremap <A-;> ,
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
nnoremap <C-k> :Buffers<CR>
nnoremap <C-p> :Files<CR>
nnoremap <leader>/ :BLines<CR>
nnoremap <leader><leader> :noh<CR>
nnoremap <leader>m :Neomake<CR>
nnoremap <leader>s :StripWhitespace<CR>
nnoremap <silent> <leader>rg :Rg <CR>

augroup setup
  au! BufEnter * EnableStripWhitespaceOnSave
  au! BufRead,BufNewFile *.md setlocal spell
  au! BufWritePost * Neomake
  au! FileType gitcommit set tw=72
  au! FileType gitcommit setlocal spell
  au! FileType haskell nnoremap <silent> <leader>ai
        \ vip :sort r /\u.*/<CR> <Bar> :Tabularize /^import qualified\\|^import\\|^$<CR>
  au! FileType javascript setlocal formatprg=prettier\ -single-quote\ --trailing-comma\ none
  au! TermOpen * setlocal conceallevel=0 colorcolumn=0
augroup END

command! -bang BLines
  \ call fzf#vim#buffer_lines(<q-args>, {'options': '--no-color'}, <bang>0)
command! -bang Lines
  \ call fzf#vim#lines(<q-args>, {'options': '--no-color'}, <bang>0)
command! -bang Ag
  \ call fzf#vim#ag(<q-args>, {'options': '--no-color'}, <bang>0)
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=never '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
