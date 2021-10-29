Class FS.EmpSQLOperation Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Property Adapter As EnsLib.SQL.OutboundAdapter;

Parameter INVOCATION = "Queue";

Method Execute(pRequest As FS.EmpRequest, Output pResponse As Ens.Response) As %Status
{
	//他システムに渡すSQLを組み立てる
	set sql="insert into ABCSystem.Employee (Name,Location,Area,EMPID) values(?,?,?,?)"
	
	//アダプタ経由でSQLの更新文を外部システムに依頼する
	// 第1引数は影響を受けた行数が登録される出力引数、第2引数は外部システムに渡すSQL
	// 第3引数以降はSQLの引数
	set status=..Adapter.ExecuteUpdate(.nrows,sql,pRequest.Name,pRequest.Location,pRequest.Area,pRequest.EMPID)
	quit status
}

XData MessageMap
{
<MapItems>
	<MapItem MessageType="FS.EmpRequest"> 
		<Method>Execute</Method>
	</MapItem>
</MapItems>
}

}
