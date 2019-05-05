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

" Autoinstall Vim-Plug on unix-like system - to install or update plugins:
if has('unix')
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
endif

function! BuildYCM(pluginfo)
    " pluginfo is a dictionary with 3 fields
    " - name: name of the plugin
    " - status: 'installed', 'updated', or 'unchanged'
    " - force: set on PlugInstall! or PlugUpdate!
    if a:info.status == 'installed' || a:info.force
        !./install.py
    endif
endfunction

call plug#begin()
Plug 'https://github.com/bronsen/vombato-colorscheme'
" YouCompleteMe for Autocomplete code
Plug 'https://github.com/Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
Plug 'https://github.com/easymotion/vim-easymotion'     "\\s to jump to letter
Plug 'vim-scripts/taglist.vim'                          " TlistToggle command to open/close the taglist
Plug 'https://github.com/scrooloose/nerdtree'           "help NERD_tree.txt
Plug 'https://github.com/nvie/vim-flake8'
Plug 'https://github.com/jceb/vim-orgmode'
Plug 'https://github.com/w0rp/ale.git'
Plug 'https://github.com/majutsushi/tagbar'
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'Yggdroot/LeaderF', { 'do': '.\install.bat' }
call plug#end()

"auto-close preview window after exit INSERT mode
let g:ycm_autoclose_preview_window_after_insertion = 1

"ALE plugin options:
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

" Tagbar set to F8:
nmap <F8> :TagbarToggle<CR><C-w>w

" Backup, swap and undo files:
set backupdir=$HOME/vimfiles/.backup/,~/.backup/,/tmp//,$TEMP/vimtmp/,$VIMRUNTIME\\tmp\\\\
set directory=$HOME/vimfiles/.swp/,~/.swp/,/tmp//,$TEMP/vimtmp/,$VIMRUNTIME\\tmp\\\\
set undodir=$HOME/vimfiles/.undo/,~/.undo/,/tmp//,$TEMP/vimtmp/,$VIMRUNTIME\\tmp\\\\

"Tabs for Python
set tabstop=4 
set shiftwidth=4
set smarttab
set expandtab "Tabs after spaces
set softtabstop=4 "4 spaces in 1 tab
set autoindent
" highlight all what is possible to highlight
let python_highlight_all = 1
"set 256 colors, it's needed in many terminals, for example in gnome-terminal
set t_Co=256

"Auto change workdir to dir of opened file
set autochdir
"
"Setting omnicomletion for Python (and also for js, html and css)
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

"Autocomple by tab
function InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\"
  else
    return "\<c-p>"
  endif
endfunction

" Show all autocomplete options
"imap <c-r>=InsertTabWrapper() 
set complete=""
set complete+=.
set complete+=k
set complete+=b
set complete+=t
"
" Trunc spaces before save (only in .py files)
autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``
" In .py files turn on smart indents after keywords
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
"
"
" call SnippletsEmu using ctrl-j
" insted tab by defaults (tab is used for autocomplete)
let g:snippetsEmu_key = "<C-j>"
"
colorscheme vombato
set guifont=hack:h11
syntax on
set nu " lines number on
set mousehide "when typing text
set mouse=a "Turn mouse support on
set termencoding=utf-8 
set novisualbell "don't blink
set t_vb= "don't squeak
"smart backspace
set backspace=indent,eol,start whichwrap+=<,>,[,]
"Don't showtabline
set showtabline=0
"Column for show "+" on code blocks
set foldcolumn=1
" transfer long lines to other line, break lines.
" Change only how file is dispalyed
set wrap
set linebreak

set encoding=utf-8 " Encoding for files by default
set fileencodings=utf8,cp1251 " Possible file encodings, if no unicode we will use cp1251

set history=1000 " Prefer to save long commands and search patterns history

" highlights the search when typing
set incsearch

" Use python3
let g:pymode_python = 'python3'
"
" use F4 for search in current and all included dirs
map <F4> :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR>

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

" indent after an nested paren
let pyindent_nested_paren="&sw*2"
" indent after an open paren
let pyindent_open_paren="&sw*2"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" For example you can % by if and endif
if has('syntax') && has('eval')
  packadd matchit
endif

" Default function for comparing two buffers by diff command
set diffexpr=MyDiff()

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
