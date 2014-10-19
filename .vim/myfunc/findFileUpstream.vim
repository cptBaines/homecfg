" ===========================================================================
" Searches backwards from current dir after a file with a given name
" ===========================================================================
function! FindFileUpstream(path,file)
	" Stop case
	" echo expand(a:file)
	if expand(a:path) =~ '^/$'
		return "none"
	endif

	" echo "Testing: " . expand(a:path) . "/" . expand(a:file)
	if filereadable(expand(a:path) . "/" .  expand(a:file))
	       return expand(a:path) . "/" . expand(a:file)	
	endif

	" recurse
	" echo "Apath: " . expand(a:path) 
   	" echo "Shrink: " . fnamemodify(expand(a:path), ":h")
	return FindFileUpstream(fnamemodify(expand(a:path), ":h"), eval('a:file'))
endfunction
