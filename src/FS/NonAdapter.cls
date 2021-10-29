Class FS.NonAdapter Extends Ens.BusinessService
{

Method OnProcessInput(pInput As FS.EmpRequest, Output pOutput As %RegisteredObject) As %Status
{
	//入力されたFS.EmpRequestをFS.EmpProcessに送信するため、SendRequestAsync()を実行
	set status=..SendRequestAsync("FS.EmpProcess",pInput)
	quit status
}

}
