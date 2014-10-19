function! GenAccessors(line)
	" Remove any class initializations assingments
	let assign = split(a:line, '=')

	" split left hand side on whitespace or ';' 
	let words = split(get(assign,0), '\s\+\|;')

	" Use the last two words as type and name respectively
	let revword = reverse(words)
	let name = get(revword, 0)
	let type = get(revword, 1)

	" Make first letter in name upper case
	let uname = substitute(name, "^[a-z]", "\\U&", "")

	" construct the getter method
	let getter =  ["","\tpublic " . type . " get" . uname . "() {return this." . name . ";}"]
	" construct the setter method
	let setter =  "\tpublic void set" . uname . "(" . type . " " . name . ") {this." . name . " = " . name . ";}"

	" Serach backwart to the closest class declaration
	?class
	" Find class closing bracket
	normal ][

	" Get lineno before closing bracket
	let lineno = line(".") - 1
	" Output getter
	let res = append(lineno, getter)
	" Get lineno before closing bracket
	let lineno = line(".") - 1
	let res = append(lineno, setter)

endfunction
