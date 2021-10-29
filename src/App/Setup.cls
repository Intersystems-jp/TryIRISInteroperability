Class App.Setup
{
ClassMethod SetRESTPath() As %Status
{
	#dim ex As %Exception.AbstractException
	set status=$$$OK
	try {
		new $namespace
		//サービス実行用パスの作成
		set $namespace="%SYS"
		set webName = "/production"
		set webProperties("DispatchClass") = "FS.REST"
		set webProperties("NameSpace") = "USER"
		set webProperties("Enabled") = 1
		set webProperties("AutheEnabled") = 96
		set webProperties("MatchRoles")=":%All"
		$$$ThrowOnError(##class(Security.Applications).Create(webName, .webProperties))

		//ABCSystem用パスの作成
		set $namespace="%SYS"
		set webName = "/ABCSystem"
		set webProperties("DispatchClass") = "ABCSystem.REST"
		set webProperties("NameSpace") = "USER"
		set webProperties("Enabled") = 1
		set webProperties("AutheEnabled") = 96
		set webProperties("MatchRoles")=":%All"
		$$$ThrowOnError(##class(Security.Applications).Create(webName, .webProperties))
	}
	catch ex {
		set status=ex.AsStatus()
	}
	return $$$OK
}
ClassMethod CreateSQLGW() As %Status
{
	#dim ex As %Exception.AbstractException
	set status=$$$OK
    try {
        // JDBCを利用するSQLゲートウェイの設定
        set jdbcgw=##class(%Library.SQLConnection).%New()
        set jdbcgw.Name="ABCSystem"
        set jdbcgw.URL="jdbc:IRIS://localhost:1972/USER"
        set jdbcgw.Usr="_SYSTEM"
        set jdbcgw.classpath=".:/usr/irissys/dev/java/lib/JDK18/intersystems-jdbc-3.2.0.jar"
        set jdbcgw.driver="com.intersystems.jdbc.IRISDriver"
        set jdbcgw.isJDBC=1
        set jdbcgw.pwd="SYS"
        set status=jdbcgw.%Save()
    }
    catch ex {
        set status=ex.AsStatus()
    }
    return status

}
}