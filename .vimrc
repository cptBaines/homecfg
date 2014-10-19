" ===========================================================================
" Settings
" ===========================================================================

" Enable patogen
execute pathogen#infect()

" Enable filtype stuff
filetype on
filetype plugin on
filetype indent on

" Enable syntax highlighting
syntax on

" choose easy readable colors
colorscheme mycolor

" Fix statusline hilighting
hi StatusLine cterm=bold
hi StatusLineNC cterm=reverse

" Show me when i'm over 80 columns wide
call matchadd('colorcolumn', '\%81v', 100)

" Contol the character shown for the list command
exec "set listchars=tab:>\uBB,trail:~,nbsp:_,eol:$"

" Choose a desentgui font
set guifont=Bitstream\ Vera\ Sans\ Mono:h13

" Make it ok to have an unwritten buffer that is not visible
set hidden

" disable bloody beeping
set vb

" tweak the statusline and show it even if we just have one window
set stl=%f\ %{fugitive#statusline()}\ %m\ %r\ Line:%l/%L[%p%%]\ Col:%c\ Buf:\ #%n\ [%b][0x%B]
set laststatus=2 

" Get rid of the menubar, its just in the way
set guioptions=ac

" Keep some history
set history=10

" set commandline height to two rows
set ch=2

" Make the 'cw' and like commands put a $ at the end instead of just deliting
" the text and replacing it. B is included to handle conflicts with snipmate
set cpoptions=Bces$

" Don't update the display while executing macros
set lazyredraw

" Show the current command in the lower right cornder
set showcmd

" Show the current mode
set showmode

" When the page starts to scroll, keep the cursor 8 lines from the top and 8
" lines from the bottom
set scrolloff=8

" expand tabs no, no
set noexpandtab


function! Addsequence()
	exe "normal! 02wywkiCREATE SEQUENCE \<Esc>pi_seq increment by 1;\<Esc>"
	exe "normal! jj$ha default nextval('\<Esc>pi_seq'::regclass)\<Esc>"
endfunction

" ===========================================================================
" Sourceig other files
" ===========================================================================
source .vim/myfunc/workJournal.vim

" ===========================================================================
" Mappings
" ===========================================================================

" grep mapping
"nnoremap ,g execute ":grep! -R " . shellescape(expand("<cWORD>")) . " ."<cr>:copen<cr>
nnoremap <silent> ,g :echom "execute grep! . '<cWORD>' ."<cr>

" Make it easy to edit vimrc (mnemonic is 'e'dit 'v'imrc)
nnoremap <silent> ,ev :e $MYVIMRC<cr>

" Make it easy to source the changed settings (mnemonic is 's'ource 'v'imrc)
nnoremap <silent> ,sv :so $MYVIMRC<cr>

" cd to the directory containing the file in the buffer
nnoremap ,cd :lcd %:h<cr>

" disable highlight search
nnoremap ,n :set invhls:set hls?<cr>

inoremap <esc> <nop>
inoremap jk <esc>

" cscope mapping
" mnemonic is f(ind) s(ymbol)
nnoremap ,fs :cs find s <c-r>=expand("<cword>")<cr><cr>
