Class EnsUtils.Rule.FunctionSet Extends Ens.Rule.FunctionSet
{

ClassMethod BLOBToBase64RFC2045MIMELines(stream As %Stream) As %ListOfDataTypes
{
	set b64 = ##class(%Library.ListOfDataTypes).%New()
	do stream.Rewind()
	set b64stream = ##class(%Stream.TmpCharacter).%New()
	while ( 'stream.AtEnd ) {
		set b = $system.Encryption.Base64Encode( stream.Read() )
		do b64stream.Write( b )
	}
	do b64stream.Rewind()
	set chunkSize = 76
	while ( 'b64stream.AtEnd ) {
		/* What is this +2, -2 stuff on chunkSize?
		   It removes the \r\n which is embedded in the Base64 encoding */
		set chunk = b64stream.Read( chunkSize + 2)
		set line = $extract( chunk, 1, (chunkSize - 2) )
		do b64.Insert( line )  	
	}
	return b64
}

}

