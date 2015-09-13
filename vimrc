" ----------------------------------- "
"		Vundle - Vim Plugins	      "
" ----------------------------------- "
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

Bundle 'gmarik/vundle'

" Git in Vim
Bundle 'tpope/vim-fugitive'

" Support
Bundle 'sjl/gundo.vim'
Bundle 'vim-indent-object'
Bundle 'indent-motion'
Bundle 'scrooloose/syntastic'
Bundle 'Shougo/vimproc.vim'
" Bundle 'jgdavey/tslime.vim'
" Bundle 'ervandew/supertab'
Bundle 'nathanaelkane/vim-indent-guides'

" Bars, panels and files
" Bundle 'scrooloose/nerdtree.git'
" Bundle 'wincent/Command-T'
" Bundle 'majutsushi/tagbar'

" Text manipulation
Bundle 'godlygeek/tabular'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle 'vim-scripts/Align'

" Python
" Bundle 'davidhalter/jedi-vim'

" Completion
" Bundle 'Shougo/neocomplete.vim'

" Haskell
" Bundle 'raichoo/haskell-vim'
" Bundle 'eagletmt/ghcmod-vim'
" Bundle 'eagletmt/neco-ghc'
" Bundle 'Twinside/vim-hoogle'

" let NERDTreeIgnore = ['\.pyc$']
" set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim

" ----------------------------------- "
"		Settings                      "
" ----------------------------------- "
set encoding=utf-8
syntax enable
filetype plugin indent on " Load file type plugins + indentation

set showcmd               " Display incomplete commands
set noshowmode            " Display the mode
set showmatch             " Show matching brackets

set tabstop=4
set shiftwidth=4
set softtabstop=4         " Tab is two spaces
set expandtab             " Expand tab into spaces
set autoindent            " Match indentation of previous line
set pastetoggle=<F2>

set incsearch             " Find as you type search

set nu                    " Show line numbers
set cursorline            " Highlight current line
set wildmode=list:longest " Complete files like a shell

set laststatus=2          " Always show statusline

set background=dark
colorscheme molokai       " Set a colorscheme
" Set colorcolumn from 80 characters onward
let &colorcolumn=join(range(80,999),",")
" Set the colorcolumn color
highlight ColorColumn ctermbg=236

" Turn off tab expanding when working on a Makefile or makefile
:autocmd BufNewFile,BufRead [Mm]akefile* setl noexpandtab tabstop=8

" Jedi vim settings
" Disable autocompletion
let g:jedi#completions_enabled = 0

" Command T ignore
set wildignore+=*.pyc

" Syntastic
let g:syntastic_check_on_open=1
let g:syntastic_enable_balloons=0
let g:syntastic_auto_loc_list=1
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_python_pylint_args = "--rcfile=~/.pylintrc"

" Set to auto read when a file is changed
set autoread

" Haskell
augroup haskell
    " autocmd FileType haskell let g:neocomplete#enable_at_startup = 1
    autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
    autocmd FileType haskell map <silent> <leader><cr> :noh<cr>:GhcModTypeClear<cr>:SyntasticReset<cr>
augroup END

" Set 7 lines to the cursor
set so=7

" Search options
set ignorecase
set hlsearch


" ----------------------------------- "
"  Functions                          "
" ----------------------------------- "
" Move current tab into the specified direction.
"
" @param direction -1 for left, 1 for right.
function! TabMove(direction)
    " get number of tab pages.
    let ntp=tabpagenr("$")
    " move tab, if necessary.
    if ntp > 1
        " get number of current tab page.
        let ctpn=tabpagenr()
        " move left.
        if a:direction < 0
            let index=((ctpn-1+ntp-1)%ntp)
        else
            let index=(ctpn%ntp)
        endif

        " move tab page.
        execute "tabmove ".index
    endif
endfunction

func! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc

augroup whitespace
    autocmd!
    autocmd BufWrite * :call DeleteTrailingWS()
augroup END


" ----------------------------------- "
"  Keybindings                        "
" ----------------------------------- "
let mapleader = ","
map gr :tabprev<CR>
map <F5> :echo expand('%:p')<CR>
map <c-t> :NERDTreeTabsToggle<CR>
map <F6> :call TabMove(-1)<CR>
map <F7> :call TabMove(1)<CR>
map <F8> :TagbarToggle<CR>
map <F4> :GundoToggle<CR>
map <Leader>8 :SyntasticToggle<CR>
let g:CommandTAcceptSelectionTabMap=['<CR>', '<C-t>']
cabbrev q lcl\|q


" Slime
vmap <silent> <Leader>rs <Plug>SendSelectionToTmux
nmap <silent> <Leader>rs <Plug>NormalModeSendToTmux
nmap <silent> <Leader>rv <Plug>SetTmuxVars

" Alignment
" Stop Align plugin from forcing its mappings on us
let g:loaded_AlignMapsPlugin=1
" Align on equal signs
map <Leader>a= :Align =<CR>
" Align on commas
map <Leader>a, :Align ,<CR>
" Align on pipes
map <Leader>a<bar> :Align <bar><CR>
" Prompt for align character
map <leader>ap :Align

" Tabular
let g:haskell_tabular = 1

" Slime {{{

vmap <silent> <Leader>rs <Plug>SendSelectionToTmux
nmap <silent> <Leader>rs <Plug>NormalModeSendToTmux
nmap <silent> <Leader>rv <Plug>SetTmuxVars

" }}}

" Type of expression under cursor
nmap <silent> <leader>ht :GhcModType<CR>
" Insert type of expression under cursor
nmap <silent> <leader>hT :GhcModTypeInsert<CR>
" GHC errors and warnings
nmap <silent> <leader>hc :SyntasticCheck ghc_mod<CR>
" Haskell Lint
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['haskell'] }
nmap <silent> <leader>hl :SyntasticCheck hlint<CR>

" Hoogle the word under the cursor
nnoremap <silent> <leader>hh :Hoogle<CR>

" Hoogle and prompt for input
nnoremap <leader>hH :Hoogle

" Hoogle for detailed documentation (e.g. "Functor")
nnoremap <silent> <leader>hi :HoogleInfo<CR>

" Hoogle for detailed documentation and prompt for input
nnoremap <leader>hI :HoogleInfo

" Hoogle, close the Hoogle window
nnoremap <silent> <leader>hz :HoogleClose<CR>
