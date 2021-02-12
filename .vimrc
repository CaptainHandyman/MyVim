set number
set tabstop=4
set shiftwidth=4
set softtabstop=4
set wildmenu
set encoding=utf-8 nobomb
set autoread
set ruler
set hlsearch
set lazyredraw
set showmatch
set nobackup
set nowb
set noswapfile
set smarttab
set expandtab
set ai
set si
set magic
set cursorline
set laststatus=2
set ignorecase
set smartcase
set incsearch
set showmatch
set wrap
set nowrap
set guifont=DejaVu\ Sans\ Mono:h11

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

fu! MyTabLabel(n)
    let buflist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)
    let string = fnamemodify(bufname(buflist[winnr - 1]), ':t')
    return empty(string) ? '[unnamed]' : string
endfu

fu! MyTabLine()
    let s = ''
    for i in range(tabpagenr('$'))
        " select the highlighting
        if i + 1 == tabpagenr()
            let s .= '%#TabLineSel#'
        else
            let s .= '%#TabLine#'
        endif

        " set the tab page number (for mouse clicks)
        "let s .= '%' . (i + 1) . 'T'
        " display tabnumber (for use with <count>gt, etc)
        let s .= ' '. (i+1) . ' '

        " the label is made by MyTabLabel()
        let s .= ' %{MyTabLabel(' . (i + 1) . ')} '

        if i+1 < tabpagenr('$')
            let s .= ' |'
        endif
    endfor
    return s
endfu
set tabline=%!MyTabLine()

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

syntax on

" colorscheme zenburn
colorscheme onehalflight

set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'https://github.com/ycm-core/YouCompleteMe'
Plugin 'preservim/nerdtree'
Plugin 'Chiel92/vim-autoformat'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

call vundle#end()            " required
filetype plugin indent on    " required

map <C-n> :NERDTreeToggle<CR>
map <C-t> :tabnew<CR>
map <C-f> :Autoformat<CR>
map <S-r> :tabclose<CR>
map <C-Right> :tabnext<CR>
map <C-Left> :tabprevious<CR>
map <S-w> :write<CR>

nnoremap <F3> :nohl<CR>

let g:ycm_global_ycm_extra_conf = '~/.vim/ycm/.ycm_extra_conf.py'
let g:ycm_keep_logfiles = 1
let g:ycm_log_level = 'debug'
let g:ycm_key_invoke_completion = '<C-Space>'
let g:ycm_clangd_args = ['--header-insertion=never']
let g:ycm_autoclose_preview_window_after_insertion = 1

let g:airline_theme='onehalfdark'

au FileType * au BufWrite * :Autoformat

au BufRead,BufNewFile *.imp set filetype=cpp
