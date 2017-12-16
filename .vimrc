set encoding=utf-8
scriptencoding: Vim
filetype plugin indent on
set ruler
set number
set fenc=utf-8
set cursorline
set cursorcolumn
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=0
set hlsearch
set cindent
set showcmd
set ignorecase
set smartcase
set nowrapscan
set noincsearch
set backspace=indent,eol,start
set clipboard=unnamed,autoselect
set list

let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#add('Shougo/vimproc.vim', {'build': 'make'})
  let s:toml = '~/.vim/rc/dein.toml'
  let s:lazy_toml = '~/.vim/rc/dein_lazy.toml'
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif

" vimprocを最初にインスコ
if dein#check_install(['vimproc'])
  call dein#install(['vimproc'])
endif

if dein#check_install()
  call dein#install()
endif


inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    return (pumvisible() ? "\<C-y>" : "") . "\<CR>"
endfunction

inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

autocmd colorscheme molokai highlight Visual ctermbg=8
syntax on
