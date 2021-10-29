Class FS.LocationToAreaDTL Extends Ens.DataTransformDTL [ DependsOn = FS.EmpRequest ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='FS.EmpRequest' targetClass='FS.EmpRequest' create='new' language='objectscript' >
<assign value='..Lookup("LocationToArea",source.Location,"エリア99")' property='target.Area' action='set' />
<assign value='source.Name' property='target.Name' action='set' />
<assign value='source.Location' property='target.Location' action='set' />
<assign value='source.EMPID' property='target.EMPID' action='set' />
</transform>
}

}
