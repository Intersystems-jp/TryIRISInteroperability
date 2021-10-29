Class FS.EmpRESTOperation Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.HTTP.OutboundAdapter";

Property Adapter As EnsLib.HTTP.OutboundAdapter;

Parameter INVOCATION = "Queue";

Method PostEmployee(pRequest As FS.EmpRequest, Output pResponse As Ens.Response) As %Status
{
	#dim ex As %Exception.AbstractException
	#dim pHttpResponse As %Net.HttpResponse
	set status=$$$OK
	try {
		//要求メッセージをJSONに変換しストリームに保存する
		do pRequest.%JSONExportToStream(.stream)	
		set status=..Adapter.Post(.pHttpResponse,,stream)

		//HTTP応答が200以外が返された場合
		if pHttpResponse.StatusCode'=200 {
			//ステータスエラーにHTTPレスポンスのメッセージ（JSON）を追加する。
			set status=$$$ERROR($$$EnsErrGeneral,$$$StatusDisplayString(status)_":"_pHttpResponse.Data.Read())
		}
	}
	catch ex {
		set status=ex.AsStatus()
	}
	return status  //quit status　も同じ
}

XData MessageMap
{
<MapItems>
	<MapItem MessageType="FS.EmpRequest"> 
		<Method>PostEmployee</Method>
	</MapItem>
</MapItems>
}

}
