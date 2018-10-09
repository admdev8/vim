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

set encoding=utf-8
set colorcolumn=100
set number
set cursorline          " highlight current line
inoremap jk <Esc>
inoremap kj <Esc>
colorscheme ron


" From the Google Python Style guide
" https://github.com/google/styleguide/blob/gh-pages/pyguide.md
" Indent Python in the Google way.

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
