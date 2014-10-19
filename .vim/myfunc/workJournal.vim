" ===========================================================================
" Work related fucntions for opening a journal file with todays date
" Calculate task durations
" And opening meeting files
"
" Also includes some conveniance mappings
" ===========================================================================
function! Journal()
	let journal = "~/doc/diary/" . strftime("%Y%m%d") . ".otl"
	execute "e " . journal
endfunction

function! Trim(string)
	return substitute(a:string, '^\s*\(.\{-}\)\s*$', '\1', '')
endfunction

function! PartitionLine(line)
	let parted = substitute(a:line, 
\ 		'^\(\d\+:\d\+\)\s*-\s*\(\d\+:\d\+\)\s*\([^|]*\) |\s*\(.*\)', 
\		'\1#\2#\3#\4','')

	" Do a case sensitive check
	if parted !=# a:line
		return parted
	endif

	" If we get here assume no stop time and try
	" another prartitioning
	let parted = substitute(a:line, 
\ 		'^\(\d\+:\d\+\)\s*\([^|]*\) |\s*\(.*\)', 
\		'\1#\2#\3#\4','')
	
	" Do a case sensitive check
	if parted !=# a:line
		return parted
	else
		return ""
	endif
endfunction

function! Duration(line)
	let partlist = split(PartitionLine(a:line), "#")
	if len(partlist) != 4
		return
	endif

	let beg = split(partlist[0], ":")
	let end = split(partlist[1], ":")
	" get hours
	let begh = str2nr(beg[0])
	let endh = str2nr(end[0])
	" get minutes
	let begm = str2nr(beg[1])
	let endm = str2nr(end[1])

	let dur = (endh - begh + (((endm - begm)%60)/60.0))
        execute "normal! o" . printf("\t: Duration: %.2f h", dur)
endfunction

" Open a new meeting file named on the pattern <date>-<start>_<company>
function! Meeting(line) 
	" get the date from current buffer name (20140111.otl)
	let mdate = expand("%:t:r")
	let partlist = split(PartitionLine(a:line), "#")
	let partlen = len(partlist)
	if partlen <= 2 || partlen > 4 
		echom "Error could not create meeting from line: " . a:line
		return
	endif
	let mtime = substitute(partlist[0], ':','','g')
	let company = substitute(partlist[(partlen-2)], '\s','_','g')
	let mbegstr = substitute(mdate, '\(\d\d\d\d\)\(\d\d\)\(\d\d\)',
\		'\1-\2-\3', '') . " " . partlist[0]
	let fname = mdate . "-" . mtime . "_" . company
	let meeting = "~/doc/meeting/" . fname 
	let tag =  "\<tab>_tag_" . fname . "\<cr>\<tab>\<tab>" . meeting

	execute "normal! o" . tag 
	execute "e " . meeting
	call append(0, partlist[partlen-1])
	execute "normal! oTime:\<tab>" . mbegstr
	execute "normal! oPlace:\<tab>"
	execute "normal! o\<cr>Attendees:\<tab>"
	execute "normal! ggYp"
	s/./=/g
endfunction

" ===========================================================================
" Mappings
" ===========================================================================

" open/create todays journal 'o'pen 'j'ournal
nnoremap ,oj :call Journal()<cr> 
" add todays date at first line in journal 's'tamp 'j'ournal 
nnoremap ,sj :call append(0, strftime("%a %b %d %Y %H:%M") ." -")<cr>

nnoremap ,d :call Duration(getline("."))<cr>
nnoremap ,D :g/^\\d/call Duration(getline("."))<cr>
nnoremap ,m :call Meeting(getline("."))<cr>

" meeting notes markup mnemonic 't'o'd'o, 'w'aiting 'f'or, 'fa'ct,
" 'i'n'v'estigate, 'de'sicion, 'su'mmary 
nnoremap ,td 0i [ ]<tab>
nnoremap ,wf 0i ( )<tab>
nnoremap ,fa 0i  *<tab>
nnoremap ,iv 0i  ?<tab>
nnoremap ,de 0i  !<tab>
nnoremap ,su 0i  =<tab>

