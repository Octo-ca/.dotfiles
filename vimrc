" vim:fdm=marker
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIMRC
"""""""""""
" autor: Stoffel
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" yes it's 2013
set nocompatible
" VUNDLE {{{
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
syntax on

" Bundles for vim
Bundle 'vundle'
" treeview of undo history
Bundle 'sjl/gundo.vim'
" .editorconfig
Bundle 'editorconfig-vim'
" fuzzy finder
Bundle 'ctrlp.vim'
" zoom into a window
Bundle 'ZoomWin'
" jshint
Bundle 'vim-scripts/jshint.vim'
" fuzzy code completion
Bundle 'Valloric/YouCompleteMe'
" { surround stuff }
Bundle 'tpope/vim-surround'
" multiple cursors
Bundle 'terryma/vim-multiple-cursors'
" ack finds your stuff
Bundle 'mileszs/ack.vim'
" git for vim
Bundle 'tpope/vim-fugitive'
" more git
Bundle 'airblade/vim-gitgutter'
" will find your syntax errors
Bundle 'scrooloose/syntastic'
" Fileexplorer
Bundle 'The-NERD-tree'
" you should write some comments
Bundle 'The-NERD-Commenter'
" Bufferexplorer
Bundle 'Buffergator'
" repeat your actions .
Bundle 'repeat.vim'
" the missing pairs
Bundle 'unimpaired.vim'
" lorem ipsum dolor.
Bundle 'loremipsum'
" what a beauty
Bundle 'maksimr/vim-jsbeautify'
" substitute
Bundle 'abolish.vim'
" textobj {{{2
Bundle 'textobj-function'
Bundle 'textobj-indent'
Bundle 'textobj-user'
" 2}}}
" Languages {{{2
Bundle "pangloss/vim-javascript"
Bundle "ajf/puppet-vim"
Bundle "vim-ruby/vim-ruby"
Bundle "effkay/argonaut.vim"
" 2}}}
Bundle 'altercation/vim-colors-solarized'

filetype plugin indent on "enable loading plugin
syntax enable
" SOLARIZED {{{2
set bg=light
" solarized options
let g:solarized_termcolors = 16
if has("gui_running")
    let g:solarized_termcolors = 256
endif
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
colorscheme solarized
hi! link SignColumn LineNr
function! Darken()
    set bg=dark
    hi! link SignColumn LineNr
endfunction
function! Lighten()
    set bg=light
    hi! link SignColumn LineNr
endfunction

function! ToggleBG()
    if &background == 'dark' | call Lighten()
    else                      | call Darken()
    endif
    hi statusline guifg=#b58900 ctermfg=black guibg=#fdf6e3 ctermbg=230
endfunction

" 2}}}
" }}}
" GUI ? {{{
" check if gui or in shell
if has("gui_running") && system('ps xw | grep "Vim -psn" | grep -vc grep') > 0
    " Get the value of $PATH from a login shell.
    " If your shell is not on this list, it may be just because we have not
    " tested it.  Try adding it to the list and see if it works.  If so,
    " please post a note to the vim-mac list!
    if $SHELL =~ '/\(sh\|csh\|bash\|tcsh\|zsh\)$'
        let s:path = system("echo echo VIMPATH'${PATH}' | $SHELL -l")
        let $PATH = matchstr(s:path, 'VIMPATH\zs.\{-}\ze\n')
    endif
endif
" }}}
" Config {{{
" tabs are 4 spaces {{{2
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
" 2}}}
" title {{{2
set title
set titlestring=%{getcwd()}\ -\ \(\ %t\ \)\ %a%r%m titlelen=70
" 2}}}
set antialias
set encoding=utf-8  " what else
set scrolloff=3
set showmode
set showcmd
set list
set listchars=tab:~\ ,trail:.
set hidden  " hide buffers instead of closing
set wildmenu
set wildmode=full
set path=**
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set number
" search {{{2
set ignorecase          " case insensitive searching
set smartcase           " but become case sensitive if you type uppercase
set incsearch
set showmatch
set hlsearch
" 2}}}
set autoread            " auto read when a file is changed from the outside
set mouse=a
set pastetoggle=<F4>
set cmdheight=1
" add register for os clipboard {{{2
set clipboard+=unnamed
set clipboard+=unnamedplus
" 2}}}
" wildignores {{{2
set wildignore+=**/node_modules/**
set wildignore+=**/components/**
set wildignore+=**/.bundle/**
set wildignore+=**/.sass-cache/**
set wildignore+=**/Library
set wildignore+=**/Movies
set wildignore+=**/Google\ Drive
set wildignore+=**/Downloads
set wildignore+=**/Documents
set wildignore+=**/Desktop
set wildignore+=**/archive
set wildignore+=**/Pictures
set wildignore+=**/Public
set wildignore+=**/3rd
set wildignore+=**/vm
" 2}}}
" statusline {{{2
if has("statusline") && !&cp
    set laststatus=2  " always show the status bar
    function! InsertStatuslineColor(mode)
        if a:mode == 'i'
            hi statusline guifg=#2aa198 ctermfg=136 guibg=#073642 ctermbg=black
        elseif a:mode == 'r'
            hi statusline guifg=#d33682 ctermfg=magenta guibg=#eee8d5 ctermbg=black
        else
            hi statusline guifg=#b58900 ctermfg=black guibg=#fdf6e3 ctermbg=230
        endif
    endfunction

    au InsertEnter * call InsertStatuslineColor(v:insertmode)
    au InsertLeave * hi statusline guifg=#b58900 ctermfg=black guibg=#fdf6e3 ctermbg=230

    " default the statusline to green when entering Vim
    hi statusline guifg=#b58900 ctermfg=black guibg=#fdf6e3 ctermbg=230
    " Start the status line
    set statusline=%<\ λ\ %f\ %h%m%r%=[\ %{&ft}\ ]\ %-14.(%l,%c%V%)\ %n#\ %0*

endif
" }}}
" Enable persistent undo {{{2
set undofile
set undodir=~/tmp/vim/undo
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
" Disable swapfile and backup {{{2
set nobackup
set noswapfile
" 2}}}
" }}}
" Plugins {{{1
" ctrlP {{{2
autocmd FocusGained * ClearCtrlPCache
" TODO test with geofy:
let g:ctrlp_working_path_mode = 0
" 2}}}
" SYNTASTIC {{{2
highlight SyntasticErrorSign cterm=none gui=none ctermfg=88 guifg=#870000
highlight SyntasticWarningSign cterm=none gui=none ctermfg=130 guifg=#af5f00
highlight SyntasticErrorLine gui=none cterm=none
highlight SyntasticWarningLine gui=none cterm=none
let g:syntastic_enable_signs=1
let g:syntastic_check_on_open=1
let g:syntastic_enable_highlighting = 0
let g:syntastic_error_symbol='✘'
let g:syntastic_warning_symbol='✗'
" 2}}}
" }}}
" MAPPINGS {{{
" <leader>
let mapleader = ","
" general {{{2
inoremap jj <esc>
cnoremap jj <esc><cr>
" wierd double esc
inoremap <esc> <esc><esc>
nnoremap <leader>vr :split $MYVIMRC<cr>
nnoremap <leader>vl :ReloadVIMRC<cr>
" copy stuff to os clipboard {{{3
vmap <D-c> "*Y
vmap <Leader>c "*Y
" 3}}}
" 2}}}
" format file {{{2
map <Leader>f mzgg=G`z<CR>
autocmd FileType javascript noremap <buffer>  <Leader>f :call JsBeautify()<cr>
" for html
autocmd FileType html noremap <buffer> <Leader>f :call HtmlBeautify()<cr>
" for css or scss
autocmd FileType css noremap <buffer> <Leader>f :call CSSBeautify()<cr>
" 2}}}
" indentation {{{2
vnoremap > > gv
vnoremap < < gv
nnoremap > V>><Esc>
nnoremap < V<<<Esc>
" 2}}}
" there should be a better use for the arrow keys {{{{2
map <Left> <NOP>
map <Right> <NOP>
map <Up> <NOP>
map <Down> <NOP>
" 2}}}
" Bubble single&multiple lines {{{2
nmap <S-Up> ddkP
nmap <S-Down> ddp
vmap <S-Up> xkP`[V`]
vmap <S-Down> xp`[V`]
" 2}}}
" Git {{{2
nmap <Leader>gs :Gstatus<cr>
nmap <Leader>ga :Git add --all<cr>
nmap <Leader>gc :Gcommit<cr>
nmap <Leader>gp :Git push<cr>
nmap <Leader>gl :Git pull<cr>
nmap <Leader>gd :Gdiff<cr>
" 2}}}
" ctrlP {{{2
map <Leader>t :CtrlP<cr>
" 2}}}
" NERDTree {{{2
map <leader>o :NERDTreeToggle %<cr>
" 2}}}
" Gundo {{{2
map <leader>g :GundoToggle<cr>
" 2}}}
" Solarized {{{2
map <F2> :ToggleBG<cr>
cnoremap ToggleBG call ToggleBG()<cr>
" 2}}}
" }}}
" COMMANDS {{{
command! ReloadVIMRC execute "source ~/.vimrc"
command! SudoWrite execute "w !sudo tee %"

" }}}
" Abbreviations {{{
iabbrev @@    schtoeffel@gmail.com
" }}}
" localvimrc {{{
if filereadable('.vimrc.local') " Do we have local vimrc?
    " If so, go ahead and load it.
    source .vimrc.local
endif
" }}}
