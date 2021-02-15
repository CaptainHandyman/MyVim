set number
set tabstop=4
set softtabstop=4
set shiftwidth=4
set wildmenu
set noswapfile
set completeopt-=preview
set smarttab
set shiftround
set hlsearch
set incsearch
set smartcase
set display+=lastline
set encoding=utf-8
set linebreak
set wrap
set laststatus=2
set ruler
set cursorline

set background=light
colorscheme PaperColor

syntax on

filetype plugin on

call plug#begin('~/.vim/plugged')

Plug 'https://github.com/rhysd/vim-clang-format'
Plug 'https://github.com/ycm-core/YouCompleteMe'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'https://github.com/preservim/nerdtree'
Plug 'NLKNguyen/papercolor-theme'

call plug#end()

let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AllowShortIfStatementsOnASingleLine" : "true",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "C++11"}

" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>


nnoremap <S-t> :tabnew<CR>
nnoremap 9 :tabprevious<CR>
nnoremap 0 :tabnext<CR>
nnoremap \ :tabclose<CR>
noremap <S-f> :ClangFormat<CR>
noremap <C-n> :NERDTreeToggle<CR>
noremap <f3> : nohl<CR>
noremap <f4> : w<CR>

let g:clang_format#auto_format=1

let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='base16_ashes'

let g:ycm_global_ycm_extra_conf = '~/.vim/ycm/.ycm_extra_conf.py'

let NERDTreeShowHidden=1
