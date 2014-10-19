fun! s:AddTable(db, tabName) 
	echom a:tabName	
	let a:db[a:tabName] = {}
endf

fun! s:AddField(tab, fieldName, fieldType)
	let a:tab[a:fieldName] = a:fieldType	
endf

fun! Test()
	let mydb = {}
	call s:AddTable(mydb, "Table1")
	call s:AddField(mydb["Table1"], "Field1", "integer")
	call s:AddField(mydb["Table1"], "Field2", "varchar")
	call s:AddField(mydb["Table1"], "Field3", "date")
	echo mydb
endf
