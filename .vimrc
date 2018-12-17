"" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2000 Mar 29
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

"set nowrap         " Don't wrap long lines
set wrap           " Wrap long lines
set nolist         " Makes sure linebreak works
set linebreak      " Don't split words at end of lines
set autoindent     " Do auto-indenting
set nocindent      " But don't do wacky C style indenting
set bs=2		   " allow backspacing over everything in insert mode
set showmatch      " always set showmatch on
set expandtab      " Use spaces instead of tabs
set softtabstop=4  " Use spaces instead of tabs
set tabstop=4      " If you insist on using tabs, use the same tabstop
set backup		   " keep a backup file (defaults to .filename~)
set viminfo='20,\"50  " read/write a .viminfo file, don't store more than 50 lines of registers
set history=50     " keep 50 lines of command line history
set ruler          " show the cursor position all the time
set number         " show line numbers

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

if has("autocmd")
    autocmd BufNewFile,BufRead Makefile set noexpandtab " Makefiles ensure that we don't expand tabs since tabs are special
endif


" lhs comments -- select a range then hit ,# to insert hash comments
" or ,/ for // comments, or ,c to clear comments.
map ,## :s/^/#/<CR> <Esc>:nohlsearch <CR>
map ,// :s/^/\/\//<CR> <Esc>:nohlsearch <CR>
"map ,c :s/^\/\/\\|^--\\|^> \\|^[#"%!;]//<CR> <Esc>:nohlsearch<CR>

" wrapping comments -- select a range then hit ,* to put  /* */ around
" selection, or ,d to clear them
map ,** :s/^\(.*\)$/\/\* \1 \*\//<CR> <Esc>:nohlsearch<CR>
map ,d :s/^\([/(]\*\\|<!--\) \(.*\) \(\*[/)]\\|-->\)$/\2/<CR> <Esc>:nohlsearch<CR>

" to clear hlsearch -- hit ,h to clear highlighting from last search
map ,h :nohlsearch <CR>

"-----------------------------------------------------------------
""Table of Contents
"1: Basic
"2: Plugin
"3: Custom
"4: Folding
"5: Search and Replace
"6: Windows
"7: Tabs
"8: Buffers
"9: Text movement
"10: Comment
"11: Abbreviations
"12: Text edits
"13: Vimdiff
"-----------------------------------------------------------------
""1: Basic
let mapleader = "," 
let maplocalleader = "\\"
"Open .vimrc in an instant
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
"Sourcing mapping
nnoremap <leader>sv :source $MYVIMRC<cr>
"Set
set number
"set mouse=a
set mouse=c
set hlsearch incsearch
"File specifics
set laststatus=2          " Causes status line to be displayed always(help laststatus)
"set statusline=%f         " Path to the file
"set statusline+=%=        " Switch to the right side
"set statusline+=%l        " Current line
"set statusline+=/         " Separator
"set statusline+=%L        " Total lines
noremap <C-l> :nohl<CR><C-l>  
"Case
set ignorecase
set smartcase
"set spell
"-----------------------------------------------------------------
""2: Plugin
"Pathogen
"Temporarily diable plugins
let g:pathogen_disabled = []
call add(g:pathogen_disabled, 'vim-bufferline')
call add(g:pathogen_disabled, 'vim-easymotion')
call add(g:pathogen_disabled, 'neocomplete.vim')
call add(g:pathogen_disabled, 'kde-colors-solarized')
call add(g:pathogen_disabled, 'cscope_maps.vim')
execute pathogen#infect()
call pathogen#helptags() " generate helptags for everything in 'runtimepath'

syntax on
"syntax off
filetype plugin indent on
"-----------------------------------------------------------------
"Vim Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
"let g:airline_powerline_fonts = 1
let g:airline_theme='term'

"Adding total lines count to the command line
function! AirlineInit()
  let g:airline_section_z = airline#section#create(['%3p%%', ':', '%4l/%4L', ':', '%3v'])
endfunction
autocmd VimEnter * call AirlineInit()

"Encoding
set encoding=utf-8
"-----------------------------------------------------------------
"Vim-colors-solarized
"set t_Co=256
set background=dark
colorscheme solarized
let g:solarized_termcolors=256
"let g:solarized_termcolors=16
"let g:solarized_visibility = "high"
"let g:solarized_contrast = "high"
colorscheme solarized

call togglebg#map("<F5>")

"Added the following lines in ~/.vim/bundle/vim-colors-solarized/colors/solarized.vim file (line 305-308)
""if &background == "dark"     
""  let s:base03 = "NONE"     
""  let s:base02 = "NONE"     
""endif
"

if has('gui_running')
   set background=light
else
   set background=dark
endif
"-----------------------------------------------------------------
"Neocomplete
"let g:neocomplete#enable_at_startup = 1
"-----------------------------------------------------------------
"NERDTree
let g:NERDTreeDirArrows=0
map <silent> NE :call NERDTreeFindAndToggle()<cr>

let g:nerdtree_is_open = 0

function! NERDTreeFindAndToggle()
  if g:nerdtree_is_open
      NERDTreeToggle
      let g:nerdtree_is_open = 0
      execute g:nerdtree_return_to_window . "wincmd w"
  else
      let g:nerdtree_return_to_window = winnr()
      NERDTreeFind
      let g:NERDTreeWinSize = 31
      set winfixwidth
      let g:nerdtree_is_open = 1
  endif
endfunction

"map <silent> NE :NERDTreeToggle<CR>
"map <silent> NE :NERDTreeToggle<CR><C-w><C-p>:NERDTreeFind<CR> 
"map <silent> NE :NERDTreeFind<CR> 
""-----------------------------------------------------------------
""Easymotion
"map  / <Plug>(easymotion-sn)
"omap / <Plug>(easymotion-tn)
"
"map  gn <Plug>(easymotion-next)
"map  gN <Plug>(easymotion-prev)
"
"map <Leader>l <Plug>(easymotion-lineforward)
"map <Leader>j <Plug>(easymotion-j)
"map <Leader>k <Plug>(easymotion-k)
"map <Leader>h <Plug>(easymotion-linebackward)
"
"let g:EasyMotion_smartcase = 1
"-----------------------------------------------------------------
"ctrlp
let g:ctrlp_map = '<c-p>'
"let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_cmd = 'CtrlPMixed'
"let g:ctrlp_max_files = 0
"let g:ctrlp_max_depth = 40
"let g:ctrlp_working_path_mode = ""
"-----------------------------------------------------------------
"DelimitMate
let delimitMate_expand_cr = 1
"-----------------------------------------------------------------
"Tagbar
nmap <F8> :TagbarToggle<CR>
let g:tagbar_ctags_bin = '/tool/pandora64/hdk-4.8.1/19/bin/ctags'
"-----------------------------------------------------------------
"Cscope
"nmap f <c-\> 
cs add $CSCOPE_DB
"-----------------------------------------------------------------
"ctags
set tags=./tags;/proj/zna_correlation/abkashyap/zensimDir
noremap <leader>t :!ctags-proj.sh<cr>
"Ctrl+W Ctrl+] - Open the definition in a horizontal split
"set nocst
map c[ :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
"map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
"-----------------------------------------------------------------
"Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

map <silent> TE :<C-u>call ToggleErrors()<cr>
function! ToggleErrors()
  if empty(filter(tabpagebuflist(), 'getbufvar(v:val, "&buftype") is# "quickfix"'))
     " No location/quickfix list shown, open syntastic error location panel
     Errors
  else
     lclose
  endif
endfunction

let g:syntastic_mode_map = { 
   \ 'mode': "passive",
   \ 'active_filetypes': [],
   \ 'passive_filetypes': [] }

nnoremap <F2> :call SyntasticCheckAndSyntasticToggle()<CR> 
let g:syntasticCheck_is_open = 0

function! SyntasticCheckAndSyntasticToggle()
  if g:syntasticCheck_is_open
      SyntasticToggle
      SyntasticToggle
      let g:syntasticCheck_is_open = 0
  else
      SyntasticCheck
      let g:syntasticCheck_is_open = 1
  endif
endfunction
"-----------------------------------------------------------------
""3: Custom
"noremap <A-j> <ESC>
"noremap! <A-j> <ESC>
"-----------------------------------------------------------------
""4: Folding
"set foldmethod=indent "syntax
map <SPACE> za
map z<SPACE> zA
"-----------------------------------------------------------------
""5: Search and Replace
noremap ;; :%s:::g<LEFT><LEFT><LEFT>
noremap ;' :%s:::gc<LEFT><LEFT><LEFT><LEFT>
cmap ;\ \(\)<LEFT><LEFT>
nnoremap <leader>g :silent execute "grep! -R " . shellescape(expand("<cWORD>")) . " ."<cr>:copen<cr>
"-----------------------------------------------------------------
""6: Windows
"map c <Nop>
nnoremap c <c-w>
map cc <Nop>
nnoremap ch <c-w>h
nnoremap cj <c-w>j
nnoremap ck <c-w>k
nnoremap cl <c-w>l
nnoremap cp <c-w><c-p>
"maximize current window both ways in one shot
nnoremap cm :res<cr>:vertical res<cr>
nnoremap ci <c-w>=
nnoremap c, <c-w>10<
nnoremap c. <c-w>10>
nnoremap c; <c-w>10+
nnoremap c' <c-w>10-
"-----------------------------------------------------------------
""7: Tabs
noremap tn :tabnew<CR>
noremap td :tabclose<CR>
noremap th :tabprev<CR>
noremap tl :tabnext<CR>
noremap tk :tabfirst<CR>
noremap tj :tablast<CR>
noremap mv :args % \|vertical all<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
noremap ms :args % \|sp all
"-----------------------------------------------------------------
"8: Buffers
nnoremap <leader>bb :buffers<CR>:buffer<SPACE>
nnoremap bd :bd<CR>
nnoremap bn :bn<CR>
nnoremap bp :bp<CR>
"-----------------------------------------------------------------
""9: Text movement
"nnoremap <S-j> :m .+1<CR>==
"nnoremap <S-k> :m .-2<CR>==
"inoremap <C-j> <Esc>:m .+1<CR>==gi
"inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <S-j> :m '>+1<CR>gv=gv
vnoremap <S-k> :m '<-2<CR>gv=gv
"-----------------------------------------------------------------
""10: Comment
"set filetype
"Java"
augroup Java
    autocmd!
    autocmd FileType java nnoremap <leader>c <S-i>//<ESC>
    autocmd FileType java inoremap <leader>c <ESC><S-i>//
    autocmd FileType java vnoremap <leader>c :s/^/\/\//<CR>
augroup END
"C"
augroup C
    autocmd!
    autocmd FileType c nnoremap <leader>c <S-i>//<ESC>
    autocmd FileType c inoremap <leader>c <ESC><S-i>>//
    autocmd FileType c vnoremap <leader>c :s/^/\/\//<CR>
augroup END
"C++"
augroup C++
    autocmd!
    autocmd FileType cpp nnoremap <leader>c I//<ESC>
    autocmd FileType cpp inoremap <leader>c <ESC>I//
    autocmd FileType cpp vnoremap <leader>c :s/^/\/\//<CR>
augroup END
"Vim"
augroup Vim
    autocmd!
    autocmd FileType vim nnoremap <leader>c <S-i>"<ESC>
    autocmd FileType vim inoremap <leader>c <ESC><S-i>"
    autocmd FileType vim vnoremap <leader>c :s/^/"/<CR>
augroup END
"Bash"
augroup Bash
    autocmd!
    autocmd FileType sh nnoremap <leader>c I#<ESC>
    autocmd FileType sh inoremap <leader>c <ESC>I#
    autocmd FileType sh vnoremap <leader>c :s/^/#/<CR>
augroup END
"Perl"
augroup Perl
    autocmd!
    autocmd FileType pl nnoremap <leader>c I#<ESC>
    autocmd FileType pl inoremap <leader>c <ESC>I#
    autocmd FileType pl vnoremap <leader>c :s/^/#/<CR>
augroup END
"Python"
augroup Python
    autocmd!
    autocmd FileType py nnoremap <leader>c I#<ESC>
    autocmd FileType py inoremap <leader>c <ESC>I#
    autocmd FileType py vnoremap <leader>c :s/^/#/<CR>
augroup END
"Configuration"
augroup Cfg
    autocmd!
    autocmd FileType cfg nnoremap <leader>c I#<ESC>
    autocmd FileType conf nnoremap <leader>c I#<ESC>
    autocmd FileType cfg inoremap <leader>c <ESC>I#
    autocmd FileType conf inoremap <leader>c <ESC>I#
    autocmd FileType cfg vnoremap <leader>c :s/^/#/<CR>
    autocmd FileType conf vnoremap <leader>c :s/^/#/<CR>
augroup END
"-----------------------------------------------------------------
""11: Abbreviations - pays attention to context unlike mappings
iabbrev adn and
iabbrev waht what
iabbrev tehn then
iabbrev teh the
"-----------------------------------------------------------------
""12: Text edits
"Vim will surround the word in double quotes!
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel
"-----------------------------------------------------------------
""13: Vimdiff
"Handy information
"]c               - advance to the next block with differences
"[c               - reverse search for the previous block with differences
"do (diff obtain) - bring changes from the other file to the current file
"dp (diff put)    - send changes from the current file to the other file
"zo               - unfold/unhide text
"zc               - refold/rehide text
"zr               - unfold both files completely

autocmd FilterWritePre * if &diff | setlocal wrap< | endif
"FilterWritePre is triggered immediately before a generated diff is written to the buffer, and 'setlocal wrap<' copies the global value of wrap. Of course it's also possible to simply force setlocal wrap

"Make use of default mapping, this mapping is not very good
"if &diff
  "noremap <Space> ]c
  "noremap <S-Space> [c
"endif

"If I want to centre the diffs (ie. the next and prev diff must appear at the
"centre of the screen, then uncomment the vim code below

"if &diff
"noremap <Space> ]czz
"noremap <S-Space> [czz
"endif
"-----------------------------------------------------------------
