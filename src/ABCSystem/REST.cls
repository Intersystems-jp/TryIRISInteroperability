/// RESTディスパッチクラス
Class ABCSystem.REST Extends %CSP.REST
{

Parameter CONVERTINPUTSTREAM = 1;

Parameter CHARSET = "utf-8";

Parameter CONTENTTYPE = "application/json";

/// ベースURL以降のURLに対応するHTTPメソッドと処理（メソッド）の指定
XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
<Route Url="/employee" Method="POST" Call="CreateEmployee" Cors="true"/>
<Route Url="/employee" Method="GET" Call="GetAllEmployee" Cors="true"/>
<Route Url="/employee/:empid" Method="GET" Call="GetEmployee" Cors="true"/>
</Routes>
}

/// POST要求時の処理
ClassMethod CreateEmployee() As %Status
{
	#dim ex As %Exception.AbstractException
	#dim %request As %CSP.Request
	set status=$$$OK
	try {
		//登録対象Employeeのインスタンスを生成
		set newemp=##class(ABCSystem.Employee).%New()
		//HTTP要求からJSONを取り出してEmployeeのインスタンスにインポート（エラー時はcatchに移動）
		$$$ThrowOnError(newemp.%JSONImport(%request.Content.Read()))
		//インスタンス保存（エラー時はcatchに移動）
		$$$ThrowOnError(newemp.%Save())
	}
	catch ex {
		set status=ex.AsStatus()
	}
	return status
}

/// GET要求時の処理
ClassMethod GetAllEmployee() As %Status
{
	#dim ex As %Exception.AbstractException
	#dim %request As %CSP.Request
	set status=$$$OK
	try {
		set sql="select JSON_OBJECT('EMPID':EMPID,'Name':Name,'Location':Location,'Area':Area ABSENT ON NULL) as resultjson from ABCSystem.Employee"
		//SQL実行用のインスタンス生成
		set stmt=##class(%SQL.Statement).%New()
		//組み立てたSQLのコンパイル
		set status=stmt.%Prepare(sql)
		#dim rset As %SQL.StatementResult
		//SQL実行
		set rset=stmt.%Execute()
		//返送用JSON配列作成
		set array=[]
		//検索結果の前方に移動
		while rset.%Next() {
			//結果行のJSONをJSON配列に登録
			do array.%Push({}.%FromJSON(rset.resultjson))
		}
		//JSONをHTTP応答として返送
		do array.%ToJSON()
		
	}
	catch ex {
		set status=ex.AsStatus()
	}
	return status
}

/// 従業員番号を指定したGET要求の処理
ClassMethod GetEmployee(empid As %String) As %Status
{
	#dim ex As %Exception.AbstractException
	set status=$$$OK
	try {
		//指定の従業員番号のインスタンスをオープン
		set emp=##class(ABCSystem.Employee).EMPIDIndexOpen(empid)
		//インスタンスをJSONに変換しHTTP応答として返送
		do emp.%JSONExport()
	}
	catch ex {
		set status=ex.AsStatus()
	}
	return status
}

}
