" ----------------------------------- "
"		Vundle - Vim Plugins							"
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

let NERDTreeIgnore = ['\.pyc$']

" ----------------------------------- "
"		Settings													"
" ----------------------------------- "
set encoding=utf-8
syntax enable
filetype plugin indent on							" Load file type plugins + indentation

set showcmd														" Display incomplete commands
set noshowmode													" Display the mode
set showmatch													" Show matching brackets

set tabstop=2
set shiftwidth=2
set softtabstop=2											" Tab is two spaces
set expandtab													" Expand tab into spaces
set autoindent												" Match indentation of previous line
set pastetoggle=<F2>

set incsearch													" Find as you type search

set hidden
set nu																" Show line numbers
set cursorline												" Highlight current line
set wildmode=list:longest							" Complete files like a shell

set laststatus=2                      " Always show statusline

colorscheme molokai										" Set a colorscheme

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
"  Keybindings												"
" ----------------------------------- "
let mapleader = ","
map gr :tabprev<CR>
map <F5> :echo expand('%:p')<CR>
map <c-t> :NERDTreeTabsToggle<CR>
map <F6> :call TabMove(-1)<CR>
map <F7> :call TabMove(1)<CR>
map <F8> :TagbarToggle<CR>
map <c-o> :tabnew 
map <F4> :GundoToggle<CR>


" ----------------------------------- "
"  Extra source files
"  ---------------------------------- "
" Source this at the end, otherwise powerline will not work for some reason
source ~/.vim/bundle/powerline/powerline/bindings/vim/plugin/powerline.vim
