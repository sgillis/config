" ----------------------------------- "                                       
"		Vundle - Vim Plugins	      "
" ----------------------------------- "
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'

" Git in Vim
Bundle 'tpope/vim-fugitive'
" Snippets
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'garbas/vim-snipmate'
Bundle 'honza/vim-snippets'
" NERDTree filebrowser
Bundle 'scrooloose/nerdtree.git'
Bundle 'jistr/vim-nerdtree-tabs'
" Commenting
Bundle 'tpope/vim-commentary'
" Surround
Bundle 'tpope/vim-surround'
" Ctrl-P
Bundle 'kien/ctrlp.vim'
" EasyMotion
Bundle 'Lokaltog/vim-easymotion'
" Repeat
Bundle 'tpope/vim-repeat'
" Tagbar for browsing source code, needs exuberant-ctags
Bundle 'majutsushi/tagbar'
" Powerline statusline
Bundle 'Lokaltog/powerline'
" Indent object selection
Bundle 'vim-indent-object'
" Indent motion
Bundle 'indent-motion'
" View undo history
Bundle 'sjl/gundo.vim'
" Tabular for lining up text
Bundle 'godlygeek/tabular'
" Automatic complete popup menu
" Bundle 'othree/vim-autocomplpop'
" L9 is needed for automatic complete
Bundle 'L9'
" Flake8 python checker
Bundle 'vim-flake8'
" Command-T (needs ruby support, found in vim-nox)
Bundle 'wincent/Command-T'
" Jedi Vim code completion
Bundle 'davidhalter/jedi-vim'

let NERDTreeIgnore = ['\.pyc$']
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim

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

" Hidden buffers
" set hidden

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
:autocmd BufNewFile,BufRead [Mm]akefile* set noexpandtab tabstop=8
" Call Flake8 check if saving python file
" :autocmd BufWritePost *.py call Flake8()

" Jedi vim settings
" Disable autocompletion
" let g:jedi#completions_enabled = 0

" Command T ignore
set wildignore+=*.pyc


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
" map <c-o> :tabnew 
map <F4> :GundoToggle<CR>
map <Leader>8 :call Flake8()<CR>
let g:CommandTAcceptSelectionTabMap=['<CR>', '<C-t>']


" ----------------------------------- "
"  VirtualEnvs (thanks to kvsn)       "
" ----------------------------------- "
function! <SID>LoadVirtualEnv()
    if $VIRTUAL_ENV != ''
        python import os
        python activation_script = os.environ['VIRTUAL_ENV'] + '/bin/activate_this.py'
        python execfile(activation_script, dict(__file__=activation_script))
        let config = $VIRTUAL_ENV . '/.vimrc'
        if filereadable(config)
            " To load omnicomplete autocompletion for a Django project, put
            " the following in your virtualenv's .vimrc config:
            " python os.environ['DJANGO_SETTINGS_MODULE'] = '<application>.settings'
            exec 'source ' . config
        endif
    endif
endfunction

call <SID>LoadVirtualEnv()
