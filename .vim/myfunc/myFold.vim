set foldtext=MyVimFoldLine()
function! MyVimFoldLine() " {{{
	let line=getline(v:foldstart)
	if match(line, '^function!.*') == 0
		let heading = substitute(line, '^function!\s*\(\w\+([^)]*)\).*', '\1','')
	endif
	let n = v:foldend - v:foldstart
	return printf("+- %3d: %s", n, heading)
endfunction
"}}}
