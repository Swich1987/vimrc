set langmenu=en_US.UTF-8    " sets the language of the menu (gvim)
"language en                 " sets the language of the messages / ui (vim)
:set nocp   "no compatible
:set number "show string number
:set ruler  "show line and column number of cursor
:set laststatus=2   "always show status line

"Vim-Plug init:
" list of plugin. Examples:
" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
" Plug 'junegunn/vim-easy-align'
" Plug 'https://github.com/junegunn/vim-github-dashboard.git'
""if (s:os_type == 'unix')
""    print ('unix')
""endif
""
""if (s:os_type == 'win32')
""    print ('windows')
""endif

"call plug#begin('~/.vim/bundle')
call plug#begin()
Plug 'https://github.com/bronsen/vombato-colorscheme'
Plug 'https://github.com/Valloric/YouCompleteMe', { 'do': '.\install.py' }        "Autocomplete code
Plug 'https://github.com/easymotion/vim-easymotion'     "\\s to jump to letter
Plug 'vim-scripts/taglist.vim'                          " TlistToggle command to open/close the taglist
Plug 'https://github.com/scrooloose/nerdtree'           "help NERD_tree.txt
Plug 'https://github.com/nvie/vim-flake8'
" Plug 'https://github.com/vim-syntastic/syntastic'
Plug 'https://github.com/jceb/vim-orgmode'
Plug 'https://github.com/w0rp/ale.git'
Plug 'https://github.com/majutsushi/tagbar'
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'Yggdroot/LeaderF', { 'do': '.\install.bat' }
call plug#end()
"PlugInstall "-to install or update plugins

"auto-close preview window after exit INSERT mode
let g:ycm_autoclose_preview_window_after_insertion = 1

"ALE options:
let g:ale_sign_column_always = 1
let g:airline#extensions#ale#enabled = 1
nmap <silent> [n <Plug>(ale_previous_wrap)
nmap <silent> ]n <Plug>(ale_next_wrap)
map <C-c> :ALELint
let g:ale_lint_on_text_changed = 'never' "disable check on text_changing
let g:ale_lint_on_enter = 0  "disable check on opening
let g:ale_set_quickfix = 1  "quickfix window ON
" :help ale-options
" :help ale-linter-options
" :help ale#statusline#Count()
" :help ale-lint-file-linters
"
" Tagbat:
nmap <F8> :TagbarToggle<CR><C-w>w

"Syntastic options
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 0
" let g:syntastic_check_on_wq = 0
""" let g:syntastic_py_pylint_args = "--disable=R0903"
""" let g:syntastic_py_pylint_args = "--rcfile=C:\Users\Asus\AppData\Local\Programs\Python\Python36-32\Lib\site-packages\pylint\standart.rc"
" map ]n :lnext<CR>
" map [n :lprevious<CR>
" map [<space> :lfirst<CR>
" map ]<space> :llast<CR>

"Хранение временных файлов в другой директории
set backupdir=$TEMP//
set directory=$TEMP//
"Настройки табов для Python, согласно рекоммендациям
set tabstop=4 
set shiftwidth=4
set smarttab
set expandtab "Ставим табы пробелами
set softtabstop=4 "4 пробела в табе
"Автоотступ
set autoindent
"Подсвечиваем все что можно подсвечивать
let python_highlight_all = 1
"Включаем 256 цветов в терминале, мы ведь работаем из иксов?
"Нужно во многих терминалах, например в gnome-terminal
set t_Co=256

"Автоматическая смена рабочего каталога на каталог открытого файла
set autochdir
"
"Настройка omnicomletion для Python (а так же для js, html и css)
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
"
"Авто комплит по табу
function InsertTabWrapper()
let col = col('.') - 1
if !col || getline('.')[col - 1] !~ '\k'
return "\"
else
return "\<c-p>"
endif
endfunction
"Показываем все полезные опции автокомплита сразу
"imap <c-r>=InsertTabWrapper() 
set complete=""
set complete+=.
set complete+=k
set complete+=b
set complete+=t
"
"Перед сохранением вырезаем пробелы на концах (только в .py файлах)
autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``
"В .py файлах включаем умные отступы после ключевых слов
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
"
""""Дальше мои личные настройки, 
""""в принципе довольно обычные, может кому надо
"
"Вызываем SnippletsEmu(см. дальше в топике) по ctrl-j
"вместо tab по умолчанию (на табе автокомплит)
let g:snippetsEmu_key = "<C-j>"
"
colorscheme vombato "(wombat была) Цветовая схема
set guifont=hack:h11
syntax on "Включить подсветку синтаксиса
set nu "Включаем нумерацию строк
set mousehide "Спрятать курсор мыши когда набираем текст
set mouse=a "Включить поддержку мыши
set termencoding=utf-8 "Кодировка терминала
set novisualbell "Не мигать 
set t_vb= "Не пищать! (Опции 'не портить текст', к сожалению, нету)
"Удобное поведение backspace
set backspace=indent,eol,start whichwrap+=<,>,[,]
"Вырубаем черточки на табах
set showtabline=0
"Колоночка, чтобы показывать плюсики для скрытия блоков кода:
set foldcolumn=1
"
"Переносим на другую строчку, разрываем строки
set wrap
set linebreak
"
"Вырубаем .swp и ~ (резервные) файлы
set nobackup
set noswapfile
set encoding=utf-8 " Кодировка файлов по умолчанию
set fileencodings=utf8,cp1251 " Возможные кодировки файлов, если файл не в unicode кодировке,
" то будет использоваться cp1251
"
"Vziato otsuda:
"https://habrahabr.ru/post/74128/
" ========КОНЕЦ================
" NERDTree ON
"autocmd vimenter * NERDTree
"
"
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin
"
set diffexpr=MyDiff()
set incsearch
"
if v:progname =~? "evim"
  finish
endif
"
" Get the defaults that most users want.
"source $VIMRUNTIME/defaults.vim
"
if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif
"
if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif
"
" Only do this part when compiled with support for autocommands.
if has("autocmd")
"
  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!
"
  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
"
  augroup END
"
else
"
  set autoindent		" always set autoindenting on
"
endif " has("autocmd")
"
" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
if has('syntax') && has('eval')
  packadd matchit
endif
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction
"
let g:pymode_python = 'python3'
"поиск в текущем и дочерних каталогах слова под курсором
map <F4> :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR>
"cd d:\Python\

" ===Indent Python in the Google way.===

setlocal indentexpr=GetGooglePythonIndent(v:lnum)

let s:maxoff = 50 " maximum number of lines to look backwards.

function GetGooglePythonIndent(lnum)

  " Indent inside parens.
  " Align with the open paren unless it is at the end of the line.
  " E.g.
  "   open_paren_not_at_EOL(100,
  "                         (200,
  "                          300),
  "                         400)
  "   open_paren_at_EOL(
  "       100, 200, 300, 400)
  call cursor(a:lnum, 1)
  let [par_line, par_col] = searchpairpos('(\|{\|\[', '', ')\|}\|\]', 'bW',
        \ "line('.') < " . (a:lnum - s:maxoff) . " ? dummy :"
        \ . " synIDattr(synID(line('.'), col('.'), 1), 'name')"
        \ . " =~ '\\(Comment\\|String\\)$'")
  if par_line > 0
    call cursor(par_line, 1)
    if par_col != col("$") - 1
      return par_col
    endif
  endif

  " Delegate the rest to the original function.
  return GetPythonIndent(a:lnum)

endfunction

let pyindent_nested_paren="&sw*2"
let pyindent_open_paren="&sw*2"
