" https://realpython.com/vim-and-python-a-match-made-in-heaven/


" VIM-PLUG
" Install vim-plug if it is not already installed
" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'vim-syntastic/syntastic'
call plug#end()


" PLUGIN SETTNGS
" nerdtree
:nnoremap <C-g> :NERDTreeToggle<CR>
" Quit nerdtree if it is the last buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"ignore files in nerdtree
let NERDTreeIgnore=['\.pyc$', '\~$']

" ycm
" Make ycm go away when done with it
let g:ycm_autoclose_preview_window_after_completion=1
" Make ycm respect virtual environment
let g:ycm_python_binary_path = 'python'
" Go to definition
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" syntastic
" recommended settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" default syntastic to just use pylint to speed it up
let g:syntastic_python_checkers = ['pylint']


" REGULAR SETTINGS
" python settings
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |
let python_highlight_all=1
syntax on

"javascript, html, css settings
au BufNewFile,BufRead *.js,*.html,*.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |

"define BadWhitespace before using in a match
highlight BadWhitespace ctermbg=red guibg=red
" Flag unnecessary whitespace
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

set encoding=utf-8
set colorcolumn=80
set number

" https://dougblack.io/words/a-good-vimrc.html
set cursorline          " highlight current line
set showcmd             " show command in bottom bar
set wildmenu            " visual autocomplete for command menu
set showmatch           " highlight matching [{()}]
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
set foldmethod=indent   " fold based on indent level
filetype indent on      " load filetype-specific indent files
" space open/closes folds
nnoremap <space> za
" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>
inoremap jk <Esc>
inoremap kj <Esc>
colorscheme ron
