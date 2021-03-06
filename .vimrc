" My vimrc created from diffent peoples vimrc's 
"
" Sections:
"    -> Plugins
"    -> General
"    -> VIM user interface
"    -> Colors and fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> Status line
"    -> Editing mappings
"    -> Vimgrep searching and cope displaying
"    -> Spell checking
"    -> Misc
"    -> Helper functions
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{ ==> Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible

" vim-plug setup
if has('nvim')
  "neovim
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
else
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
endif

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'sheerun/vim-polyglot'
"Plug 'chriskempson/base16-vim'
Plug 'matze/vim-move'
Plug 'w0rp/ale'
Plug 'maralla/completor.vim'
Plug 'davidhalter/jedi-vim'
Plug 'ervandew/supertab'
Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}
"Plug 'NLKNguyen/papercolor-theme'
"Plug 'dracula/vim'
"Plug 'jacoborus/tender.vim'
"Plug 'arcticicestudio/nord-vim'
"Plug 'lifepillar/vim-cheat40'
"
"Plug 'plytophogy/vim-virtualenv'
"Plug 'christoomey/vim-tmux-Navigator'
"Plug 'prabirshrestha/async.vim'
"Plug 'prabirshrestha/vim-lsp'
"Plug 'prabirshrestha/asyncomplete.vim'
"Plug 'prabirshrestha/asyncomplete-lsp.vim'
" List ends here. Plugins become visible to vim after this call.
call plug#end()

" Ale
" set to 1 to turn on 
" Enable completion where available
"let g:ale_completion_enabled = 1

let g:ale_fix_on_save = 0
let g:ale_fixers = {
            \ 'python': [
            \ 'isort',
            \ 'yapf',
            \ 'remove_trailing_lines',
            \ 'trim_whitespace'],
            \}

" Jedi
let g:jedi#completions_enabled = 1
"}}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"if executable('pyls')
"	" pip install python-language-server
"	au User lsp_setup call lsp#register_server({
"				\ 'name': 'pyls',
"				\ 'cmd': {server_info->['pyls']},
"				\ 'whitelist': ['python'],
"				\ })
"endif
"
"autocmd FileType python setlocal omnifunc=lsp#complete

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{ ==> General

let mapleader=","                         " change the leader to be a comma
set ruler
set background=dark
set number
set t_Co=256
set scrolloff=5
"colorscheme nord

" set PEP 8 indentation
au BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79 expandtab autoindent 

filetype plugin indent on

autocmd FileType vim,txt setlocal foldmethod=marker

"}}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{ ==> Colors
if filereadable(expand("~/.vimrc_background"))
	let base16colorspace=256
	source ~/.vimrc_background
endif
syntax on

" set popup menu colors
highlight Pmenu ctermfg=250 ctermbg=234
highlight Pmenusel ctermfg=250 ctermbg=240

let &colorcolumn="80,120"

" Fix for dimming out inactive pane in tmux
" comment out below line if not using tmux
autocmd ColorScheme * highlight! Normal ctermfg=none

"}}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{ ==> Moving around, tabs and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set splitbelow
set splitright

" ctrl-hjkl to navigate between split buffers
map <C-h> <C-W>h
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-l> <C-W>l

" lets make these all work in insert mode too ( <C-O> makes next command
" happen as if in command mode )
imap <C-W> <C-O><C-W>


"}}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{ ==> Shortcuts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" fast saving
nmap <leader>w :w<CR>

" sudo write this
cmap W! w !sudo tee % >/dev/null 

" Editing and reloading the .vimrc file
" Edit vimrc 
nnoremap <leader>ve :e $MYVIMRC<CR>
" Reload vimrc 
nnoremap <leader>vr :source $MYVIMRC<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" Quick close preview window
nnoremap <leader>z <C-W>q

" command for quick directory change
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>


"}}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{ ==> Edit mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{ <ALT-char> setting fix
" Set terminal vim to recognise <ALT-char> key mappings
" shouldn't need it for GUI vim or neovim
" Taken from https://stackoverflow.com/questions/6778961/alt-key-shortcuts-not-working-on-gnome-terminal-with-vim/10216459#10216459
"
let c='a'
while c <= 'z'
	exec "set <A-".c.">=\e".c
	exec "imap \e".c." <A-".c.">"
	let c = nr2char(1+char2nr(c))
endw

set timeout ttimeoutlen=50
" end of <ALT-char> setting fix
"}}}

"}}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
