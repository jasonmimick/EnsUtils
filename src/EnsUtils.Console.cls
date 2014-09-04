/// Set of console utilties
class EnsUtils.Console extends %RegisteredObject
{

ClassMethod Dir(object as %RegisteredObject)
{
	set result = $listbuild()
	do ..internalDir(object,.result)
	write $listtostring(result)
}
ClassMethod internalDir(object as %RegisteredObject,ByRef result as %List) [ Internal ]
{
	if ( '$isobject( object ) ) {
		set $list(result,$listlength(result))=object
		return
	}
	if object.%Extends("%Stream.Object") {
		do ..Stream(object,.result)
		return
	}
	if object.%Extends("%Library.ArrayOfDataTypes") {
		do ..ArrayOfDataTypes(object,.result)
		return
	}
	if object.%Extends("%Collection.ArrayOfDT") {
		do ..ArrayOfDataTypes(object,.result)
		return
	}	
	if object.%Extends("%Library.ListOfDataTypes") {
		do ..ListOfDataTypes(object,.result)
		return
	}
	if object.%Extends("%ZEN.proxyObject") {
		do ..ZENproxyObject(object,.result)
		return
	}
	
	do ..RegisteredObject(object,.result)

}

ClassMethod RegisteredObject(object as %RegisteredObject,ByRef result as %List) [ Internal ]
{
	set def = ##class(%ClassDefinition).%OpenId(object.%ClassName(1))
	for i=1:1:def.Properties.Count() {
		set propertyName = def.Properties.GetAt(i).Name
		set value = $property(object,propertyName)
		if ( $isobject(value) ) {
			set subResult = $listbuild()
			do ..internalDir(value,.subResult)
			set value = $listtostring(subResult)
		} 
		set $list(result,i)=propertyName_"="_value	
	}
}
ClassMethod ListOfDataTypes(list as %ListOfDataTypes,ByRef lb as %List) [ Internal ]
{
	for i=1:1:list.Count() {
		set $list(lb,i)=list.GetAt(i)
	}
}
ClassMethod ArrayOfDataTypes(array as %ArrayOfDataTypes,ByRef lb as %List) [ Internal ]
{
	set i=0,key=array.Next("")
    while ( key '= "" ) {
		set $list(lb,$increment(i))=key_"="_array.GetAt(key)	
        set key=array.Next(key)
    }
}

ClassMethod ZENproxyObject(obj as %ZEN.proxyObject,ByRef lb as %List) [ Internal ]
{
	do obj.%CopyToArray(.array)
	set i=0,key=$order(array(""))
	while ( key'="" ) {
		set value = array(key)
		if ( $isobject(value ) ) {
			set subList=$lb()
			do ..internalDir(value,.subList)
			set value = $listtostring(subList)
		}
		set $list(lb,$increment(i))=key_"="_value
		set key=$order(array(key))
	}
}

ClassMethod Stream(stream as %Stream.Object,ByRef lb as %List) [ Internal ]
{
	do stream.Rewind()
	while ( 'stream.AtEnd ) {
		write stream.Read()
	}
	write !
	set $list(lb,1)="Stream Size="_stream.Size
}
ClassMethod Test() 
{
	set array = ##class(%ArrayOfDataTypes).%New()
	for key="alpha","beta","gamma","delta" {
		do array.SetAt(key_"-value",key)
	}
	do ..Dir(array)
	write !
	set list = ##class(%ListOfDataTypes).%New()
	for i=1:1:10 {
		do list.Insert("Item # "_i)
	}
	do ..Dir(list)
	write !

	set poo=##class(%ZEN.proxyObject).%New()
	set poo.Name = "George Washington"
	set poo.President = "First"
	set poo.Horses = ##class(%ListOfDataTypes).%New()
	do poo.Horses.Insert("Fred")
	do poo.Horses.Insert("Barney")
	do ..Dir(poo)
	write !
	do ..Dir("FooBar!")
	write !

	set s=##class(%Stream.TmpCharacter).%New()
	for i=1:1:10 {
		set chunk=""
		for i=1:1:$random(100)+1 {
			set chunk=chunk_$char($random(128))
		}
		do s.Write( $zstrip(chunk,"*W") )
	}
	do ..Dir(s)
	write !
}

}
