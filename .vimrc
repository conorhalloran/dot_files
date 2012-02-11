set nocompatible
filetype off

set rtp+=~/.vim/vundle/
call vundle#rc()

Bundle 'Shougo/neocomplcache'
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'edsono/vim-matchit'
Bundle 'groenewege/vim-less'
Bundle 'juvenn/mustache.vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'kien/ctrlp.vim'
Bundle 'majutsushi/tagbar'
Bundle 'mileszs/ack.vim'
Bundle 'msanders/snipmate.vim'
Bundle 'othree/html5.vim'
Bundle 'pangloss/vim-javascript'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'sukima/xmledit'
Bundle 'thinca/vim-quickrun'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'vim-ruby/vim-ruby'
Bundle 'xolox/vim-session'

Bundle 'Align'
Bundle 'FuzzyFinder'
Bundle 'L9'
Bundle 'Specky'
Bundle 'grep.vim'
Bundle 'php.vim'
Bundle 'sudo.vim'

filetype plugin indent on
syntax on

" key map
imap <C-j> <esc>
let mapleader=","
nnoremap <silent> cy ce<C-r>0<ESC>:let@/=@1<CR>:noh<CR>
vnoremap <silent> cy c<C-r>0<ESC>:let@/=@1<CR>:noh<CR>
nnoremap <silent> ciy ciw<C-r>0<ESC>:let@/=@1<CR>:noh<CR>
:nnoremap <C-j><C-j> :nohlsearch<CR>
set pastetoggle=<C-E>

" General
set nocompatible          " get out of horrible vi-compatible mode
filetype on               " detect the type of file
set history=10000         " How many lines of history to remember
set cf                    " enable error files and error jumping
filetype plugin indent on " Enable filetype-specific indenting and plugins
set viminfo+=!            " make sure it can save viminfo
set isk+=_,$,@,%,#,-      " none of these should be word dividers, so make them not be
set nobackup
set noswapfile
set iminsert=0
set imsearch=0

" OS dependent
if has("win32")
  set ffs=dos,unix,mac
  set guifont=MS_Gothic:h11:cSHIFTJIS
  set printfont=MS_Gothic:h9:cSHIFTJIS
  set printoptions=number:y
elseif has('mac')
  set ffs=mac,unix,dos
  set guifont=Monaco:h12
else
  set ffs=unix,dos,mac
  set guifontset=a14,r14,k14
endif

" Theme/Colors
set t_Co=256
set background=dark
"colorscheme desert
colorscheme wombat256

" Vim UI
set wildmenu     " turn on wild menu
set ruler        " Always show current positions along the bottom
set cmdheight=1  " the command bar is 2 high
set number       " turn on line numbers
set lz           " do not redraw while running macros (much faster) (LazyRedraw)
set hid          " you can change buffer without saving
set backspace=2  " make backspace work normal
set mouse=a      " use mouse everywhere
set report=0     " tell us when anything is changed via :...
set noerrorbells " don't make noise
set fillchars=vert:\ ,stl:\ ,stlnc:\
set guioptions=

" Visual Cues
set showmatch    " show matching brackets
set mat=5        " how many tenths of a second to blink matching brackets for
set hlsearch     " do not highlight searched for phrases
set incsearch    " BUT do highlight as you type you search phrase
set ignorecase
set so=10        " Keep 10 lines (top/bottom) for scope
set novisualbell " don't blink
set noerrorbells " no noises
set laststatus=2
set linespace=0
set showcmd
set nowrap
set list
set listchars=tab:\|\ ,trail:.,extends:>,precedes:< " what to show when I hit :set list
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=white
match ZenkakuSpace /　/
set statusline=%n:\ %<%f\ %m%r%h%w[%{&fileformat}][%{has('multi_byte')&&\ &fileencoding!=''?&fileencoding:&encoding}]\ 0x%B=%b%=%l,%c\ %P
let loaded_matchparen = 1

" Indent
set fo=tcrqn     " See Help (complex)
set autoindent   " autoindent
set smartindent  " smartindent
set cindent      " do c-style indenting
set smarttab     " use tabs at the start of a line, spaces elsewhere
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=0

" Folding
set foldenable        " Turn on folding
set foldmethod=indent " Make folding indent sensitive
set foldlevel=100     " Don't autofold anything (but I can still fold manually)
set foldopen-=search  " don't open folds when you search into them
set foldopen-=undo    " don't open folds when you undo stuff

" 新規ファイル保存時にディレクトリを作成する
augroup vimrc-auto-mkdir  " {{{
  autocmd!
  autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'))
  function! s:auto_mkdir(dir)  " {{{
    if !isdirectory(a:dir)
      call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
  endfunction  " }}}
augroup END  " }}}

" Enconding
set ffs=unix,dos,mac  " 改行文字
set encoding=utf-8    " デフォルトエンコーディング

" 文字コード関連
" from ずんWiki http://www.kawaz.jp/pukiwiki/?vim#content_1_7
" 文字コードの自動認識
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif

" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif

" FuzzyFinder.vim
let g:fuf_modesDisable = []
nnoremap <Space>f f
nnoremap <Space>F F
nnoremap f <Nop>
nnoremap <silent> fb :<C-u>FufBuffer!<CR>
nnoremap <silent> ff :<C-u>FufFile!<C-r>=expand('%:~:.')[:-1-len(expand('%:~:.:t'))]<CR><CR>
nnoremap <silent> fm :<C-u>FufMruFile!<CR>
nnoremap <silent> tb :<C-u>tabnew<CR>:tabmove<CR>:FufBuffer!<CR>
nnoremap <silent> tf :<C-u>tabnew<CR>:tabmove<CR>:FufFile!<C-r>=expand('#:~:.')[:-1-len(expand('#:~:.:t'))]<CR><CR>
nnoremap <silent> tm :<C-u>tabnew<CR>:tabmove<CR>:FufMruFile!<CR>

" grep.vim
let Grep_Find_Use_Xargs = 0
let Grep_Shell_Quote_Char = '"'
let Grep_Skip_Dirs        = '.svn'
let Grep_Skip_Dirs        = '.bzr'
let Grep_Skip_Files       = '*.bak *~'
" :Gb <args> でGrepBufferする
command! -nargs=1 Gb :GrepBuffer <args>
" カーソル下の単語をGrepBufferする
nnoremap <C-g><C-b> :<C-u>GrepBuffer<Space><C-r><C-w><Enter>

" FileType settings
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType html set filetype=xhtml
autocmd Filetype html set omnifunc=htmlcomplete#CompleteTags
autocmd Filetype css set omnifunc=csscomplete#CompleteCSS
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS

" functions
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis

" Tell vim to remember certain things when we exit
"  '10 : marks will be remembered for up to 10 previously edited files
"  "100 : will save up to 100 lines for each register
"  :20 : up to 20 lines of command-line history will be remembered
"  % : saves and restores the buffer list
"  n... : where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

" when we reload, tell vim to restore the cursor to the saved position
augroup JumpCursorOnEdit
 au!
 autocmd BufReadPost *
 \ if expand("<afile>:p:h") !=? $TEMP |
 \ if line("'\"") > 1 && line("'\"") <= line("$") |
 \ let JumpCursorOnEdit_foo = line("'\"") |
 \ let b:doopenfold = 1 |
 \ if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
 \ let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
 \ let b:doopenfold = 2 |
 \ endif |
 \ exe JumpCursorOnEdit_foo |
 \ endif |
 \ endif
 " Need to postpone using "zv" until after reading the modelines.
 autocmd BufWinEnter *
 \ if exists("b:doopenfold") |
 \ exe "normal zv" |
 \ if(b:doopenfold > 1) |
 \ exe "+".1 |
 \ endif |
 \ unlet b:doopenfold |
 \ endif
augroup END

vmap <silent>sf        <Plug>SQLU_Formatter<CR>
nmap <silent>scl       <Plug>SQLU_CreateColumnList<CR>
nmap <silent>scd       <Plug>SQLU_GetColumnDef<CR>
nmap <silent>scdt      <Plug>SQLU_GetColumnDataType<CR>
nmap <silent>scp       <Plug>SQLU_CreateProcedure<CR>

" syntastics
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2

" quickrun
let g:quickrun_config = {}
let g:quickrun_config['coffee'] = {'command' : 'coffee', 'exec' : ['%c -cbp %s']}

" NNERDTree
nnoremap <silent> <C-n> :NERDTreeToggle<CR>

" ctrlp
set wildignore+=*/.git/*,*/tmp/*,*/.sass-cache/*

" rst
command Rst :!rst2html.py % > /tmp/rstprev.html && open /tmp/rstprev.html

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
" AutoComplPop like behavior.
let g:neocomplcache_enable_auto_select = 1

" TagBar
nmap <F8> :TagbarToggle<CR>

" Add this type definition to your vimrc
" or do
" coffeetags --vim-conf >> <PATH TO YOUR VIMRC>
" if you want your tags to include vars/objects do:
" coffeetags --vim-conf --include-vars
 let g:tagbar_type_coffee = {
  \ 'kinds' : [
  \   'f:functions',
  \   'o:object'
  \ ],
  \ 'kind2scope' : {
  \  'f' : 'object',
  \   'o' : 'object'
  \},
  \ 'sro' : ".",
  \ 'ctagsbin' : 'coffeetags',
  \ 'ctagsargs' : ' ',
  \}
