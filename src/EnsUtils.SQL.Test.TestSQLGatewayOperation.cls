Class EnsUtils.SQL.Test.TestSQLGatewayOperation Extends %RegisteredObject
{

ClassMethod TestSamplePerson55()
{
	do ..TestSamplePerson(,"55")
}

ClassMethod TestSamplePerson(sql = "SELECT * FROM Sample.Person WHERE ID = ?", parms...)
{
	set operation = ##class(EnsUtils.SQL.SQLGatewayOperation).%New("FakeConfigName")
	set request = ##class(EnsUtils.ListOfDataTypeRequest).%New()
	if ( $data(parms) ) {
		for i=1:1:parms {
			do request.Data.Insert(parms(i))
		}
	}
	set operation.SQL = sql
	set operation.Adapter.DSN = "SamplesSQL"
	#dim response as EnsLib.SQL.Snapshot
	set sc = operation.Execute(request,.response)
	//zw response
	
	for i=1:1:response.GetColumnCount() {
		write response.GetColumnName(i)," "
	}
	
	write !,!
	while ( response.Next() ) {
		for i=1:1:response.GetColumnCount() {
			write response.GetData(i)," "
		}	
		write !
	}
	write "RowCount=",response.RowCount,!
}

}

