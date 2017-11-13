set exrc

" Based on an example for a vimrc file by Bram Moolenaar <Bram@vim.org>

if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" My customisations

" Make , the leader key
let mapleader = " "

" Use normal regex patterns, rather than Vim's bad default regex.
nnoremap / /\v
vnoremap / /\v

" Make tabs 2 spaces
set tabstop:2
set shiftwidth:2
set expandtab

" Syntax highlighting
set syntax:on

" Make the 80th column colored.
set colorcolumn=80

" Show search matches while typing
set showmatch
set ignorecase
set smartcase

" Window switching
map <Tab> <C-w>w
map <S-Tab> <C-w>W

" Moving a line of text up / down
map <C-j> :m .+1<CR>==
map <C-k> :m .-2<CR>==

" Open and focus tagbar. Provided by tagbar plugin.
nnoremap <leader>t :TagbarOpen fj<CR>

" Autoclose the tagbar after choosing an item from it.
let g:tagbar_autoclose = 1

" Run PhpCodeSniffer via syntastic
let g:syntastic_phpcs_conf=" --standard=Drupal --extensions=php,module,inc,install,test,profile,theme"

" Show hidden files in NERDTree
let NERDTreeShowHidden = 1

" Supertab completion
let g:SuperTabDefaultCompletionType = ""

" Browse for files in the current working directory to open in a new tab.
map <C-b> :NERDTreeToggle<CR>
map <C-f> :NERDTreeFind<cr>

" Define the number of files ctrlP has access to."


" Set VIM symfony mapping"
let g:symfony_enable_shell_mapping = 0 "disable the mapping of symfony console

" Use your key instead of default key which is <C-F>
map <leader>f :execute ":!"g:symfony_enable_shell_cmd<CR>

" Set symfony caller variables"
let g:symfony_app_console_caller= "php"
let g:symfony_app_console_path= "app/console"

"map <C-b>. :browse tabe .<CR> 
"map <C-b>t :Texplore<CR> 

" Set the path to the current workding directory
set path=$PWD/**

" Show gutter line numbers.
set number

" Toggle relative / absolute line numbers.
nnoremap <silent> <leader>r :exec &number ? "set rnu" : "set nornu"<CR>

" Clear search highliting.
nnoremap <leader>h :nohlsearch<CR>

" Ack shortcut
nnoremap <leader>a :Ack 

" Strip trailing whitespace.
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Close a split window with space q.
nnoremap <silent> <leader>q :hide<CR>

" Debugger settings
let g:debuggerMaxDepth = 10
let g:debuggerTimeout = 30

" Better highlight color for command-t
let g:CommandTHighlightColor='WildMenu'

" Insert 2 lines and remain on first new line
nnoremap <silent> <leader><CR> 2o<esc>ki

" Map keys for easily switching between buffers
map <leader>n :bn<cr>
map <leader>p :bp<cr>
map <leader>l :ls<cr>

" Map function keys which are unavaiable on mac
map <leader>1 <F1>
map <leader>2 <F2>
map <leader>3 <F3>
map <leader>4 <F4>
map <leader>5 <F5>
map <leader>6 <F6>
map <leader>7 <F7>
map <leader>8 <F8>
map <leader>9 <F9>
map <leader>10 <F10>
map <leader>11 <F11>
map <leader>12 <F12>

nnoremap <leader>c :!drush cc all<CR>

" Automatically expand <CR>
let delimitMate_expand_cr = 1

" Filetype associations for Drupal.
au BufRead,BufNewFile *.install set filetype=php
au BufRead,BufNewFile *.module set filetype=php
au BufRead,BufNewFile *.profile set filetype=php
au BufRead,BufNewFile *.inc set filetype=php
au BufRead,BufNewFile *.info set filetype=info
au BufRead,BufNewFile *.theme set filetype=php

" Drupal coding standards with phpcs
let g:syntastic_php_phpcs_args ="--standard=Drupal --extensions=php,module,inc,install,test,profile,theme --report=csv"

let g:syntastic_javascript_checkers = ['jshint']
" Javascript coding standards with JSHint & JSCS
"function! JavascriptLinter(curpath)
  "let parent=1
  "let local_path=a:curpath
  "let local_jscs=local_path . '.jscsrc'

  "while parent <= 255
    "let parent = parent + 1
    "let local_path = local_path . "../"
    "let local_jscs = local_path . '.jscsrc'
    "if filereadable(local_jscs)
      "return ['jscs', 'jshint']
    "endif
  "endwhile

  "unlet parent local_jscs

  "return ['jshint']
"endfunction

"let g:syntastic_javascript_checkers=JavascriptLinter(getcwd() . "/")

" jscs returns exit code when no config file is present.
" Only load it when appropriate.
"function! JavascriptCheckers()
  "if filereadable(getcwd() . '/.jscsrc')
    "return ['jshint', 'jscs']
  "else
    "return ['jshint']
  "endif
"endfunction"

"let g:syntastic_javascript_checkers=JavascriptCheckers()

" Load ctags
set tags=php.tags

" Activate pathogen plugin
call pathogen#infect()
" Activate pathogen help tags"
call pathogen#helptags()
" Disable unsafe commands
set secure
