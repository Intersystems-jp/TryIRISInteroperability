Class FS.EmpFileService Extends Ens.BusinessService
{

Parameter ADAPTER = "EnsLib.File.InboundAdapter";

Method OnProcessInput(pInput As %Stream.Object, Output pOutput As %RegisteredObject) As %Status
{
	//　ファイルに記載された情報を取得
	set line=pInput.ReadLine()
	//読み込んだ行をビジネスプロセスへリクエストメッセージとして送信するため 
	// リクエストメッセージ：FS.EmpRequestオブジェクトを新規作成します
	set request=##class(FS.EmpRequest).%New()
	//　ファイルの形式に合わせて、カンマ区切りn番目を該当するプロパティに設定します
	//　区切り文字付きの文字列操作には、$PIECE関数が便利です。
	//　	$PIECE(文字列,"区切りマーク",n番目) 
	//		サンプルでは、EMPID,Name,Location　の順番で情報が登録されるとしています
	set request.EMPID=$piece(line,",",1)
	set request.Name=$piece(line,",",2)
	set request.Location=$piece(line,",",3)
	
	//　SendRequestAsync()メソッド実行でメッセージをビジネスプロセスへ送信します
	//　第3引数は、応答メッセージを受け取りたいときに指定します（参照渡し）
	// （応答メッセージがない場合は、省略可）
	set status=..SendRequestAsync("FS.EmpProcess",request)
	quit status
}

}
