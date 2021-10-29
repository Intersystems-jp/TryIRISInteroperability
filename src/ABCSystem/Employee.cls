Class ABCSystem.Employee Extends (%Persistent, %JSON.Adaptor)
{

/// 人の名前
Property Name As %String;

Property Location As %String;

Property Area As %String;

Property EMPID As %String;

Index EMPIDIndex On EMPID [ Unique ];

Storage Default
{
<Data name="EmployeeDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
<Value name="3">
<Value>Location</Value>
</Value>
<Value name="4">
<Value>Area</Value>
</Value>
<Value name="5">
<Value>EMPID</Value>
</Value>
</Data>
<DataLocation>^ABCSystem.EmployeeD</DataLocation>
<DefaultData>EmployeeDefaultData</DefaultData>
<IdLocation>^ABCSystem.EmployeeD</IdLocation>
<IndexLocation>^ABCSystem.EmployeeI</IndexLocation>
<StreamLocation>^ABCSystem.EmployeeS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
