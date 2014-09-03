/// An Ensemble request which contains just a list of strings, ints, etc..
Class EnsUtils.ListOfDataTypeRequest Extends Ens.Request
{

// Method %OnNew(data As %ListOfDataTypes) As %Status

Method %OnNew() As %Status
{
	/*
	if ( $data(data) ) {
		if ( $isobject(data) && data.%Extends("%Library.ListOfDataTypes") ) {
			set ..Data = data
		} 
	}
	
	if ( '$data(..Data) ) {
	*/
	set ..Data = ##class(%ListOfDataTypes).%New()
	
	quit $$$OK
}

Property Data As %ListOfDataTypes;

// [ MultiDimensional ];

<Storage name="Default">
<Data name="ListOfDataTypeRequestDefaultData">
<Subscript>"ListOfDataTypeRequest"</Subscript>
<Value name="1">
<Value>Data</Value>
</Value>
</Data>
<DefaultData>ListOfDataTypeRequestDefaultData</DefaultData>
<Type>%Library.CacheStorage</Type>
</Storage>
}

