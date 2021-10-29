Class FS.REST Extends %CSP.REST
{

Parameter CONVERTINPUTSTREAM = 1;

Parameter CHARSET = "utf-8";

Parameter CONTENTTYPE = "application/json";

/// ベースURL以降のURLに対応するHTTPメソッドと処理（メソッド）の指定
XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
<Route Url="/request/:empid/:name/:location" Method="GET" Call="CallService" Cors="true"/>
</Routes>
}

/// URLの /request 以降にくる内容がそのまま引数として受け取れます
ClassMethod CallService(empid As %String, name As %String, location As %String) As %Status
{
	#dim ex As %Exception.AbstractException
	set status=$$$OK
	try {
		//プロダクションに登録されているビジネスサービスを指定してビジネスサービス実行用インスタンス生成
		$$$ThrowOnError(##class(Ens.Director).CreateBusinessService("FS.NonAdapter",.bs))
		//ビジネスサービスに渡す要求メッセージを作成
		set request=##class(FS.EmpRequest).%New()
		set request.EMPID=empid
		set request.Name=name
		set request.Location=location
		//引数に要求メッセージを指定し、ビジネスサービスのProcessInput()を呼び出す
		$$$ThrowOnError(bs.ProcessInput(request))
		set json={}
		set json.Message="依頼しました"
		do json.%ToJSON()
	}
	catch ex {
		set status=ex.AsStatus()
	}
	return status
}

}
