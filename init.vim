" file: .config/nvim/init.vim
" author: Ryan James Spencer

call plug#begin('~/.local/share/nvim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'atelierbram/Base2Tone-vim'
Plug 'godlygeek/tabular'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-mix-format'
Plug 'neomake/neomake'
Plug 'ntpeters/vim-better-whitespace'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'scrooloose/nerdcommenter'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-rooter'
Plug 'rhysd/git-messenger.vim'
Plug 'tweekmonster/fzf-filemru'

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
set wildoptions=pum
set pumblend=5

let $GIT_EDITOR = 'nvr -cc split --remote-wait' " Requires `:w | bd` to close and save.
let mapleader = ','
let g:airline#extensions#cursormode#enabled = 0 "Don't let airline mess up the cursor color
let g:airline_theme = 'Base2Tone_PoolDark'
let g:haskell_enable_quantification = 1
let g:haskell_indent_disable = 1
let g:netrw_liststyle = 0
let g:netrw_banner = 0
let g:netrw_preview = 1
let g:airline_powerline_fonts = 0
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:rustfmt_autosave = 1
let g:mix_format_on_save = 1
let g:prettier#exec_cmd_async = 1
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#autoformat = 0 " 'autoformat' only means for only files with '@format' tag.
let g:strip_whitespace_confirm = 0
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

autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx,*.css,*.less,*.scss Prettier
",*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html Prettier

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
tnoremap <A-`> <C-\><C-N>
tnoremap <leader><leader> <C-\><C-N>
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
nnoremap <A-1> 1gt<CR>
nnoremap <A-2> 2gt<CR>
nnoremap <A-3> 3gt<CR>
nnoremap <A-4> 4gt<CR>
tnoremap <A-1> <C-\><C-n>1gt<CR>
tnoremap <A-2> <C-\><C-n>2gt<CR>
tnoremap <A-3> <C-\><C-n>3gt<CR>
tnoremap <A-4> <C-\><C-n>4gt<CR>
nnoremap <C-k> :Buffers<CR>
nnoremap <c-p> :FilesMru --tiebreak=index<cr>
nnoremap <leader><space> :BLines<CR>
nnoremap <leader>q :noh<CR>
nnoremap <leader>s :StripWhitespace<CR>
nnoremap <silent> <leader>rg :Rg <CR>
nnoremap <leader>yp :let @+ = expand("%")<CR>

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=never --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%'),
  \   <bang>0)

augroup setup
  " All file types
  au! BufEnter * EnableStripWhitespaceOnSave
  au! BufWritePost * Neomake

  " Markdown
  au! BufEnter,BufRead,BufNewFile *.md setlocal
        \ tw=80
        \ spell
        \ complete+=kspell
        \ wrap
        \ linebreak
        \ nolist
  au! FileType markdown nnoremap <localleader>d :put =strftime('%c')<CR>

  " Rust
  autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/,$RUST_SRC_PATH/rusty-tags.vi
  autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!

  " Git commits
  au! FileType gitcommit setlocal
        \ tw=72
        \ spell

  " Haskell
  au! FileType haskell nnoremap <silent> <leader>ai
        \ vip :sort r /\u.*/<CR> <Bar> :Tabularize /^import qualified\\|^import\\|^$<CR>

  " JavaScript
  au! FileType javascript setlocal formatprg=prettier\ -single-quote\ --trailing-comma\ none

  " Terminal
  au! TermOpen * setlocal conceallevel=0 colorcolumn=0

  " Turn off colors for Gblame
  au FileType fugitiveblame setlocal syntax=unknown
augroup END
