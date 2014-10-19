" local syntax file - set colors on a per-machine basis:
" vim: tw=0 ts=4 sw=4
" Vim color file
" Maintainer:	Bjorn Nilsson  <bjorn@bnicon.se>
" Last Change:	2014 Sep 08

" Colorscheme intialization -- {{{
set t_Co=16
hi clear
set background=dark
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "mycolor"
" }}}

" Clear all default colors -- {{{
highlight clear colorColumn
highlight clear conceal
highlight clear cursor
highlight clear cursorIM
highlight clear cursorColumn
highlight clear cursorLine
highlight clear directory
highlight clear diffAdd
highlight clear diffChange
highlight clear diffDelete
highlight clear diffText
highlight clear errorMsg
highlight clear vertSplit
highlight clear folded
highlight clear foldColumn
highlight clear signColumn
highlight clear incSearch
highlight clear lineNr
highlight clear cursorLineNr
highlight clear matchParen
highlight clear modeMsg
highlight clear moreMsg
highlight clear nonText
highlight clear normal
highlight clear pmenu
highlight clear pmenuSel
highlight clear pmenuSbar
highlight clear pmenuThumb
highlight clear question
highlight clear search
highlight clear specialKey
highlight clear spellBad
highlight clear spellCap
highlight clear spellLocal
highlight clear spellRare
highlight clear statusLine
highlight clear statusLineNC
highlight clear tabLine
highlight clear tabLineFill
highlight clear tabLineSel
highlight clear title
highlight clear visual
highlight clear visualNOS
highlight clear warningMsg
highlight clear wildMenu
" }}}
"
" Configured defaults
"
" My own defs -- {{{
"highlight bniLink	ctermfg=11 cterm=bold
highlight bniReverse	ctermfg=0 ctermbg=16 cterm=reverse 
		      \ guifg=#e0b000 guibg=#171717 gui=reverse
highlight bniLink	ctermfg=11 ctermbg=0 
		      \ guifg=#f0c000 guibg=#171717 gui=underline
highlight bniLinkBold	ctermfg=11 ctermbg=0 cterm=bold 
		      \ guifg=#f0c000 guibg=#171717 gui=bold,underline
highlight bniBold	ctermbg=16 ctermbg=0 cterm=bold 
		      \ guifg=#ffee00 guibg=#171717 gui=bold
highlight bniComment	ctermfg=238 guifg=#555555
highlight bniAlert 	ctermfg=0 ctermbg=1 
		      \ guifg=#000000 guibg=#ff0000

" Linking some defaults
highlight! def link Cursor bniReverse
highlight! def link LineNr bniComment

" Normal and visual mode
highlight Visual	ctermbg=130 ctermfg=0 guifg=#eebb00 guibg=#22222 gui=reverse
highlight Normal	ctermbg=16 guifg=#ddaa00 guibg=#171717

" Setup status line
highlight StatusLineNC	ctermbg=234 cterm=bold guibg=#00000 gui=bold
highlight StatusLine	cterm=bold,reverse gui=bold,reverse

" Special keys tabs and trailing spaecs
highlight SpecialKey	ctermfg=238 guifg=#444444 

" Warn me when I go beyond 80 columns
" black char on red background
highlight! def link ColorColumn bniAlert 

" Make bracket matching stand out
highlight! def link MatchParen bniLinkBold

" Folding
highlight Folded	ctermbg=233
" }}}

" Programming -- {{{
highlight clear Type
highlight clear Statement
highlight clear Constant
highlight clear PreProc
highlight clear Identifier
highlight! def link Delimiter Normal
highlight! def link Identifier bniBold

" Make commets resede into the background
highlight! def link Comment bniComment
" }}}

" Vim outliner -- {{{
highlight!  clear OL1
highlight!  clear OL2
highlight!  clear OL3
highlight!  clear OL4
highlight!  clear OL5
highlight!  clear OL6
highlight!  clear OL7
highlight!  clear OL8
highlight!  clear OL9
highlight!  clear Folded
highlight!  clear FoldColumn
highlight! def link OL1 bniBold
highlight! def link OL2 bniBold
highlight! def link OL3 bniBold
highlight! def link OL4 bniBold
highlight! def link OL5 bniBold
highlight! def link OL6 bniBold
highlight! def link OL7 bniBold
highlight! def link OL8 bniBold
highlight! def link OL9 bniBold
" }}}

" Vim specific -- {{{
highlight! def link vimComment Comment
highlight! def link vimPatSep Normal
highlight! def link vimFuncVar Normal
highlight! def link vimFuncName Normal
highlight! def link vimVar Normal
highlight! def link helpCommand Identifier
highlight! def link helpExample Identifier
highlight! def link helpIdentifier Identifier
highlight! def link helpFunction Identifier
highlight! def link helpVim Identifier
highlight! def link helpHeadline Identifier
" <C-r> refs m.m.
highlight! def link helpSpecial Identifier
" Colors jump tags etc.
highlight! def link Subtitle bniLink
" }}}
