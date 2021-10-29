Class FS.EmpRequest Extends (Ens.Request, %JSON.Adaptor)
{

Property Name As %String;

Property Location As %String;

Property Area As %String;

Property EMPID As %String;

Storage Default
{
<Data name="EmpRequestDefaultData">
<Subscript>"EmpRequest"</Subscript>
<Value name="1">
<Value>Name</Value>
</Value>
<Value name="2">
<Value>Location</Value>
</Value>
<Value name="3">
<Value>Area</Value>
</Value>
<Value name="4">
<Value>EMPID</Value>
</Value>
</Data>
<DefaultData>EmpRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
