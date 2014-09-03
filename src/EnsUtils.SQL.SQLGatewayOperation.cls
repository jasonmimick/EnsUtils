/// Given a SQL query, execute it against a linked SQL data store and return a SnapShot
Class EnsUtils.SQL.SQLGatewayOperation Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Property Adapter As EnsLib.SQL.OutboundAdapter;

Parameter INVOCATION = "InProc";

Property SQL As %String(MAXLEN = 1000);

Parameter SETTINGS = "SQL:Basic";

Method Execute(pRequest As EnsUtils.ListOfDataTypeRequest, Output pResponse As EnsLib.SQL.Snapshot) As %Status
{
	set sc = $$$OK
	//set pResponse = ##class(EnsUtils.SQL.SQLGatewayResponse).%New()
	set pResponse = ##class(EnsLib.SQL.Snapshot).%New()
	try {
		for i=1:1:pRequest.Data.Count() {
			set params(i)=pRequest.Data.GetAt(i)
		}
		set params = pRequest.Data.Count()
		#dim resultSet as EnsLib.SQL.GatewayResultSet
		//set pResponse.FirstRow=1,pResponse.MaxRowsToGet=0
		zw params
		write "SQL=",..SQL,!
		$$$THROWONERROR(sc,..Adapter.ExecuteQueryParmArray(.resultSet,..SQL,.params))
		//$$$THROWONERROR(sc,..Adapter.ExecuteQueryParmArray(.pResponse,..SQL,.params))
		$$$THROWONERROR(sc,resultSet.GetSnapshot(.pResponse,1))
			
	} catch error {
		return error.AsStatus()
	}
	Quit sc
}

XData MessageMap
{
<MapItems>
	<MapItem MessageType="EnsUtils.ListOfDataTypeRequest"> 
		<Method>Execute</Method>
	</MapItem>
</MapItems>
}

}

