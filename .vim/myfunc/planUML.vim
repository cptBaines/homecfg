" File: planUML.vim
" Author: Bjorn Nilsson
" Description: Stub out classes from planUML relation descriptions 
" Last Modified: September 14, 2014

"if exists('did_planUML') || &cp || version < 700
"	finish
"endif
"let did_planUML = 1

" Datastructure
" database = { table,..., table }
" table = { constraints, field, ..., field }
" field = { name : type }
" constraints = { primaryKey, foreignKey, fieldConstraint, ...,
" fieldConstraint }
" primaryKey = { "primaryKey" : [fieldName, ..., fieldName] }
" foreignKey = { "foreignKey" : [ foreingKeyDef ]
" foreignKeyDef = { "fields" : fieldLis, "refTabs" : tabList, "type" : typeList }


function! s:AddTable(db, tabName) " {{{ 
	if ! has_key(a:db, a:tabName)
		let a:db[a:tabName] = {'constraints':{'primaryKeys':[]
		\	,'foreignKeys':[]}}
	endif
endfunction
" }}}

function! s:AddField(table, field, type) " {{{ 
	if ! has_key(a:table, a:field) 
		let a:table[a:field] = a:type
	endif
endfunction
" }}}

function! s:AddPrimaryKey(table,fieldList) " {{{
	let pk = s:GetPrimaryKeys(a:table) 
	if len(pk) == 0
		for field in a:fieldList
			call add(pk, field)
			call s:AddConstraint(a:table, field, "not null")
		endfor
	endif	 
endfunction
" }}}

function! s:NewFkDef() " {{{
	return {"fields":[],"reftabs":[],"reffield":[],"reftype":[]}	
endfunction
" }}}

function! s:AddFkFieldToDef(fkdef, db, field, refTab, refField) " {{{
	let refType = a:db[a:refTab][a:refField]
	call add(a:fkdef["fields"], a:field)
	call add(a:fkdef["reftabs"], a:refTab)
	call add(a:fkdef["reffield"], a:refField)
	call add(a:fkdef["reftype"], refType)
endfunction
" }}}

function! s:AddForeignKeyDef(table, fkDef) " {{{
	let fk = s:GetForeignKeys(a:table)
	call add(fk, a:fkDef)
	for field in a:fkDef["fields"]
		call s:AddConstraint(a:table, field, "not null")
	endfor
endfunction
" }}}

function! s:GetConstraints(table) " {{{
	return a:table["constraints"]
endfunction
" }}}

function! s:GetPrimaryKeys(table) " {{{
	return a:table["constraints"]["primaryKeys"]
endfunction
" }}}

function! s:GetForeignKeys(table) " {{{
	return a:table["constraints"]["foreignKeys"]
endfunction
" }}}

function! s:AddConstraint(table, field, const) " {{{
	let constrDict = s:GetConstraints(a:table)
	let constrDict[a:field] = a:const
endfunction
" }}}

function! s:PrintPrimaryKeys(table) " {{{
	let pk = s:GetPrimaryKeys(a:table)
	echo pk 
endfunction
" }}}

function! s:PrintForeignKeys(table) " {{{
	let fk = s:GetForeignKeys(a:table)
	echo fk 
endfunction
" }}}

function! s:PrintConstraints(table) " {{{
	let constrDict = a:table["constraints"]
	for key in keys(constrDict)
		if key !~ '\vprimaryKeys|foreignKeys'
			echo "\t\t" . key . ': ' . constrDict[key]
		endif
	endfor
endfunction
" }}}

function! s:PrintTable(table) " {{{
	for key in keys(a:table)
		if key !~ '\vconstraints|primaryKeys|foreignKeys'
			echo "\t" . key . ': ' . a:table[key]
		endif
	endfor
	echo "\tConstraints"
	call s:PrintConstraints(a:table)
	call s:PrintPrimaryKeys(a:table)
	call s:PrintForeignKeys(a:table)
endfunction
" }}}

function! s:PrintDatabase(database) " {{{
	for key in keys(a:database)
		echo key
		call s:PrintTable(a:database[key])
	endfor
endfunction
" }}}

" Slit a line on form 'tab1 "1" -- "*" tab2' into a comma
" separated string ie. 'tab1,1,*,tab2'. A relation string
" without relation counts will be parsed into 'tab1,,,tab2'
function! s:ParseRelationLine(line) " {{{
	return split(substitute(a:line
\		, '\v^(\w+)\s*("([0-9\*]*)"|)\s*--\s*("([0-9\*]*)"|)\s*(\w+)\s*$'
\		, '\1,\3,\5,\6',''), ',')
endfunction
" }}}

function! s:TableFromRelationLine(db, line) " {{{
	echom a:line
	let relParts = s:ParseRelationLine(a:line)
	let tab1 = relParts[0]
	let tab2 = relParts[3]
	let tab1Cnt = relParts[1]
	let tab2Cnt = relParts[2]

	call s:AddTable(a:db,tab1)
	call s:AddTable(a:db,tab2)

	call s:AddField(a:db[tab1], "id", "integer")
	call s:AddField(a:db[tab2], "id", "integer")
	call s:AddPrimaryKey(a:db[tab1], ["id"])
	call s:AddPrimaryKey(a:db[tab2], ["id"])
	" Handle many to many relationships
	if tab1Cnt ==# "*" && tab2Cnt ==# "*"
		let xrefTab = "xref_" . tab1 . "_" . tab2
		call s:AddTable(a:db,xrefTab)
		call s:AddField(a:db[xrefTab], tab1 . "_id", "integer")
		call s:AddField(a:db[xrefTab], tab2 . "_id", "integer")

		let fkDef = s:NewFkDef()
		call s:AddFkFieldToDef(fkDef, a:db, tab1 . "_id"
\			, tab1 , "id") 
		call s:AddFkFieldToDef(fkDef, a:db, tab2 . "_id"
\			, tab2 , "id") 
		call s:AddForeignKeyDef(a:db[xrefTab], fkDef)
	endif
	" Handle one to many relationships
	if tab1Cnt ==# "1" && tab2Cnt ==# "*"
		call s:AddField(a:db[tab2], tab1 . "_id", "integer")

		let fkDef = s:NewFkDef()
		call s:AddFkFieldToDef(fkDef, a:db, tab1 . "_id"
\			, tab1 , "id") 
		call s:AddForeignKeyDef(a:db[tab2], fkDef)
	endif
	" Handle one to many relationships
	if tab1Cnt ==# "*" && tab2Cnt ==# "1"
		call s:AddField(a:db[tab1], tab2 . "_id", "integer")

		let fkDef = s:NewFkDef()
		call s:AddFkFieldToDef(fkDef, a:db, tab2 . "_id"
\			, tab2 , "id") 
		call s:AddForeignKeyDef(a:db[tab1], fkDef)
	endif
endfunction
" }}}

function! s:OutputFkDefUML(fkDef) " {{{
	let n = len(a:fkDef["fields"])
	let i = 0
	while i < n
		echo "  fk(" . a:fkDef["fields"][i] . "," 
		\ . a:fkDef["reftabs"][i] . "." . a:fkDef["reffield"][i] . ")" 
		let i += 1
	endw
endfunction
" }}}

function! s:StubTableDefs(db) " {{{
	for tab in keys(a:db)
		echo "table(" . tab . ")\n{"
		for field  in s:GetPrimaryKeys(a:db[tab])
			let fieldType = a:db[tab][field]
			echo "  pk(" . field . "," . fieldType . ")"
		endfor
		for fkDef in s:GetForeignKeys(a:db[tab])
			call s:OutputFkDefUML(fkDef)		
		endfor
		echo "}"
	endfor
endfunction

" }}}

function! Test() " {{{
	let db = {}
	call s:TableFromRelationLine(db, 'test "*" -- "*" mytab')
	call s:TableFromRelationLine(db, 'test1 "1" -- "*" mytab1')
	call s:TableFromRelationLine(db, 'test2 "*" -- "1" mytab2')
	call s:TableFromRelationLine(db, 'test3  --  mytab4')
	call s:TableFromRelationLine(db, 'test5 "1" -- "*" mytab1')
	call s:StubTableDefs(db)
"	call s:PrintDatabase(db)
endfunction
" }}}

