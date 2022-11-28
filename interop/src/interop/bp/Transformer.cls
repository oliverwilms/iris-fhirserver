/// 
Class interop.bp.Transformer Extends Ens.BusinessProcessBPL
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Ens.Request' response='Ens.Response' height='2000' width='2000' >
<context>
<property name='interopRequest' type='HS.FHIRServer.Interop.Request' instantiate='0' />
<property name='fhirResource' type='HS.FHIR.DTL.vR4.Model.Base.Resource' instantiate='0' />
</context>
<sequence xend='200' yend='750' >
<trace name='request' value='request' xpos='200' ypos='250' />
<transform name='transformer' class='interop.dtl.Transformer' source='request' target='context.fhirResource' xpos='200' ypos='350' />
<trace name='context.fhirResource' value='context.fhirResource' xpos='200' ypos='450' />
<code name='interopRequest' xpos='200' ypos='550' >
<![CDATA[ set apiRequest = ##class(HS.FHIRServer.API.Data.Request).%New()
 set apiRequest.QueryString = ""
 set apiRequest.RequestMethod = "POST"
 set apiRequest.RequestFormatCode = "JSON" 
 set apiRequest.ResponseFormatCode = "JSON"
 set apiRequest.RequestPath = "/Patient"

 set resourceJsonStream = context.fhirResource.ToJSON()

 set quickStream = ##class(HS.SDA3.QuickStream).%New()
 set quickStreamId = quickStream.%Id()
     do quickStream.CopyFrom(resourceJsonStream)
 do quickStream.Rewind()

 set interopRequest = ##class(HS.FHIRServer.Interop.Request).%New()
 set interopRequest.QuickStreamId = quickStreamId
 set interopRequest.Request = apiRequest

 set context.interopRequest = interopRequest]]>
</code>
<call name='FHIRServer Operation' target='FHIRServer Operation' async='0' xpos='200' ypos='650' >
<request type='HS.FHIRServer.Interop.Request' >
<assign property="callrequest" value="context.interopRequest" action="set" />
</request>
<response type='HS.FHIRServer.Interop.Response' >
<assign property="response" value="callresponse" action="set" />
</response>
</call>
</sequence>
</process>
}

}
