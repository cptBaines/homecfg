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
highlight bniLink	ctermfg=11
highlight bniLinkBold	ctermfg=11 cterm=bold
highlight bniComment	ctermfg=238
highlight bniBold	ctermbg=16 cterm=bold

" Normal and visual mode
highlight visual	ctermbg=130 ctermfg=0
highlight Normal	ctermbg=16 

" Setup status line
highlight StatusLineNC	ctermbg=234 cterm=bold
highlight StatusLine	cterm=bold,reverse

" Special keys tabs and trailing spaecs
highlight SpecialKey	ctermfg=238

" Warn me when I go beyond 80 columns
highlight ColorColumn ctermbg=1

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
