syntax on
"https://github.com/gosukiwi/vim-atom-dark/blob/master/colors/atom-dark-256.vim
colorscheme atom-dark-256
set autoindent
set incsearch
set hlsearch
set ignorecase
"set laststatus=2
set ttimeoutlen=10
set backupdir=/tmp
set directory=/tmp
set modeline
set undofile
set encoding=utf-8
"set cursorcolumn
set cursorline
nnoremap <silent> <C-j> :bprev<CR>
nnoremap <silent> <C-k> :bnext<CR>
:set undodir=D:/tmp
:autocmd BufRead *.scala set cindent
:autocmd BufRead *.scala set expandtab
:autocmd BufRead *.scala set shiftwidth=4
:autocmd BufRead */libvirt/*.{c,h} set cindent
:autocmd BufRead */libvirt/*.{c,h} set expandtab
:autocmd BufRead */libvirt/*.{c,h} set shiftwidth=4
":autocmd BufRead *.py set cindent
:autocmd BufRead *.rb set autoindent
:autocmd BufRead *.rb set expandtab
:autocmd BufRead *.rb set tabstop=2
:autocmd BufRead *.rb set softtabstop=2
:autocmd BufRead *.rb set shiftwidth=2
:autocmd BufRead *.rb set smartindent
:autocmd BufRead *.py set autoindent
:autocmd BufRead *.py set expandtab
:autocmd BufRead *.py set tabstop=4
:autocmd BufRead *.py set softtabstop=4
:autocmd BufRead *.py set shiftwidth=4
:autocmd BufRead *.js set cindent
:autocmd BufRead *.js set expandtab
:autocmd BufRead *.js set softtabstop=4
:autocmd BufRead *.js set shiftwidth=4
:autocmd BufRead */qemu/*.{c,h} set cindent
:autocmd BufRead */qemu/*.{c,h} set expandtab
:autocmd BufRead */qemu/*.{c,h} set softtabstop=4
:autocmd BufRead */qemu/*.{c,h} set shiftwidth=4
:autocmd BufRead *.{cc,hh} set autoindent
:autocmd BufRead *.{cc,hh} set tabstop=4
:autocmd FileType yaml setlocal ai ts=2 sw=2 et nu cuc
:autocmd FileType yaml colo desert
":autocmd BufRead *.js set g:js_indent = ~/.vim/indent/javascript.vim
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

if has("cscope")
  if filereadable("cscope.out")
    cs add cscope.out
  endif
  map g<C-[> :cs find c <C-R>=expand("<cword>")<CR><CR>
endif
" http://stackoverflow.com/questions/13634826/vim-show-function-name-in-status-line
fun! ShowFuncName()
  let lnum = line(".")
  let col = col(".")
  echohl ModeMsg
  echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW'))
  echohl None
  call search("\\%" . lnum . "l" . "\\%" . col . "c")
endfun
map f :call ShowFuncName() <CR>
let g:CCTreeDbFileSplitLines = -1
