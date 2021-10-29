/// 
Class FS.EmpProcess Extends Ens.BusinessProcessBPL
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='FS.EmpRequest' response='Ens.Response' height='2000' width='2000' >
<context>
<property name='ConvertedRequest' type='FS.EmpRequest' instantiate='0' />
</context>
<sequence xend='200' yend='450' >
<transform name='データ変換の呼び出し' class='FS.LocationToAreaDTL' source='request' target='context.ConvertedRequest' xpos='412' ypos='281' />
<call name='POST要求' target='FS.EmpRESTOperation' async='1' xpos='657' ypos='415' >
<request type='FS.EmpRequest' >
<assign property="callrequest" value="context.ConvertedRequest" action="set" />
</request>
<response type='Ens.Response' />
</call>
</sequence>
</process>
}

}
