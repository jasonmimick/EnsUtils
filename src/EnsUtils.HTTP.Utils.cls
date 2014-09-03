/// A set of handy HTTP stuff
class EnsUtils.HTTP.Utils extends %RegisteredObject
{

ClassMethod CreateHTTPRequestWithJSONBody(object as %ZEN.proxyObject) As EnsLib.HTTP.GenericMessage
{
	set stream = ##class(%GlobalCharacterStream).%New()
	do ##class(%ZEN.Auxiliary.jsonProvider).%WriteJSONStreamFromObject(stream,object)
	do stream.Rewind()
	set http = ##class(EnsLib.HTTP.GenericMessage).%New(stream,,stream)
	do http.HTTPHeaders.SetAt(stream.Size,"content-length")
	do http.HTTPHeaders.SetAt("application/json","content-type")
	do http.HTTPHeaders.SetAt("POST","httprequest")
	return http
}


}
