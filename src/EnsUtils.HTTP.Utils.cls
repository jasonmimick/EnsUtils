/// A set of handy HTTP stuff
class EnsUtils.HTTP.Utils extends %RegisteredObject
{

ClassMethod CreateHTTPRequestWithJSONBody(object as %ZEN.proxyObject) As EnsLib.HTTP.GenericMessage
{
	set stream = ##class(%GlobalCharacterStream).%New()
	do ##class(%ZEN.Auxiliary.jsonProvider).%WriteJSONStreamFromObject(stream,object)
	do stream.Rewind()
	set http = ##class(EnsLib.HTTP.GenericMessage).%New(stream,,stream)
	return http
}


}
