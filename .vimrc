let mapleader = " "

" configure vundle plugin installer
set nocompatible              " be improved, required
filetype off                  " required

" set the runtime path to include vundle and initialize
set rtp+=~/.vim/bundle/vundle.vim
call vundle#begin()
" place all vundle plugins here...

Plugin 'thoughtbot/vim-rspec'
Plugin 'christoomey/vim-tmux-runner'
Plugin 'vim-airline/vim-airline'      " that awesome statusbar
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-eunuch'             " unix helper
Plugin 'tpope/vim-endwise'            " auto-append 'end'
Plugin 'majutsushi/tagbar'            " git in statusbar
Plugin 'junegunn/fzf'                 " fuzzy finder
Plugin 'ervandew/supertab'            " tab completion
Plugin 'junegunn/limelight.vim'       " centre-stage highlighting
Plugin 'dhruvasagar/vim-zoom'         " zoom into vim panes
Plugin 'pbrisbin/vim-mkdir'           " make dir with ease
Plugin 'leafgarland/typescript-vim'   " typescript syntax higlighting
Plugin 'valloric/youcompleteme'
Plugin 'pedrohdz/vim-yaml-folds'      " Vim yaml folds

" end the vundle config
call vundle#end()            " required
filetype plugin indent on    " required

" start the pathogen plugin
execute pathogen#infect()

" fzf configuration
set rtp+=/usr/local/opt/fzf

" use syntax higlighting
syntax on

" display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

filetype plugin indent on

" Use tomorrow-night color schemes
colorscheme Tomorrow-Night

" show numbers
set number

" right color column so you don't exceed 50 lines
set colorcolumn=80

set nowrap

" set tabstop to 2 spaces for ruby and other indent config
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent
set autoindent

" remove white spaces on save
autocmd BufWritePre * :%s/\s\+$//e

" set search
set hlsearch

" cancel a search with escape
nnoremap <silent> <Esc> :nohlsearch<Bar>:echo<CR>

" show matching parentheses
set showmatch

" open nerdtree on load
" autocmd vimenter * NERDTree

" Enable autosave
let g:auto_save = 1  " enable AutoSave on Vim startup

" Set Autosave save events
let g:auto_save_events = ["WinLeave", "FocusLost"]

" Close vim if the only window left open is nerdtree
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Add yaml syntax highlighting
au BufNewFile,BufRead *.yaml,*.yml so ~/.vim/yaml.vim

" Search word under cursor
noremap <Leader>a :Ack <cword><CR>

" Use rspec.vim
let g:rspec_command = "VtrSendCommandToRunner rspec {spec}"

" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>as :call RunAllSpecs()<CR>

" Tmux runner bindings
nnoremap <leader>va :VtrAttachToPane<cr>
nnoremap <leader>ror :VtrReorientRunner<cr>
nnoremap <leader>sc :VtrSendCommandToRunner<cr>
nnoremap <leader>sl :VtrSendLinesToRunner<cr>
vnoremap <leader>sl :VtrSendLinesToRunner<cr>
nnoremap <leader>or :VtrOpenRunner<cr>
nnoremap <leader>kr :VtrKillRunner<cr>
nnoremap <leader>fr :VtrFocusRunner<cr>
nnoremap <leader>dr :VtrDetachRunner<cr>
nnoremap <leader>cr :VtrClearRunner<cr>
nnoremap <leader>fc :VtrFlushCommand<cr>
nnoremap <leader>sf :VtrSendFile<cr>

" Fuzzy Search bindings
map <C-P> :FZF<CR>

" Allow backspace deleting
set backspace=2

" Easy Navigation between windows
nmap <silent> <Tab><Up> :wincmd k<CR>
nmap <silent> <Tab><Right> :wincmd l<CR>
nmap <silent> <Tab><Down> :wincmd j<CR>
nmap <silent> <Tab><Left> :wincmd h<CR>

" Toggle Nerdtree
nmap <silent> <Leader>tr :NERDTreeToggle<CR>

" Setup autoscrolling
" nnoremap k kzz
" nnoremap j jzz
" nnoremap p pzz
" nnoremap P Pzz
" nnoremap G Gzz
" nnoremap x xzz
" inoremap <ESC> <ESC>zz
" nnoremap <ENTER> <ENTER>zz
" inoremap <ENTER> <ENTER><ESC>zza
" nnoremap o o<ESC>zza
" nnoremap O O<ESC>zza
" nnoremap a a<ESC>zza

" Use control keys to move text up and down
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Remap 0 key to go to beginning of a word
nmap 0 ^

" Remap d and dd to copy to blank register
noremap p "*p
noremap d "1d
noremap dd "1dd
noremap x "*x
noremap yy "*yy

" Quick edit vimrc
nmap <leader>ev :tabe $MYVIMRC<cr>
nmap <leader>so :source $MYVIMRC<cr>

" New tab
map <C-t> <esc>:tabnew<cr>

" Rename current file
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction

map <Leader>n :call RenameFile()<cr>

" Edit another file in the same directory as the current file
" uses expression to extract path from current file's path
map <Leader>e :e <C-R>=escape(expand("%:p:h"),' ') . '/'<CR>
map <Leader>sp :split <C-R>=escape(expand("%:p:h"), ' ') . '/'<CR>
map <Leader>v :vnew <C-R>=escape(expand("%:p:h"), ' ') . '/'<CR>
map <Leader>d :silent !rm <C-R>=expand("%:p")<CR>

" Copy to system clipboard
map <Leader>co mmggVG"*y`m

" Set foldmethod and unfold all text
" set fdm=syntax

" buffer mappings
nnoremap <Leader>l :ls<CR>
nnoremap <Leader>b :bp<CR>
nnoremap <Leader>f :bn<CR>
nnoremap <Leader>g :e#<CR>
nnoremap <Leader>1 :1b<CR>
nnoremap <Leader>2 :2b<CR>
nnoremap <Leader>3 :3b<CR>
nnoremap <Leader>4 :4b<CR>
nnoremap <Leader>5 :5b<CR>
nnoremap <Leader>6 :6b<CR>
nnoremap <Leader>7 :7b<CR>
nnoremap <Leader>8 :8b<CR>
nnoremap <Leader>9 :9b<CR>
nnoremap <Leader>0 :10b<CR>

" For auto indent while saving
" augroup autoindent
"   au!
"   autocmd BufWritePre * :normal migg=G`i
" augroup End


" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
      \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
