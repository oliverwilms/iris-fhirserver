Class interop.Util
{

ClassMethod CreateServiceRegistry() As %Status
{
    Set tSC = $$$OK
    Set tService = ##class(HS.Registry.Service.HTTP).%New()
    Set tService.Host = "localhost"
    Set tService.Name = "external-fhirserver-basic"
    Set tService.Port= 52773
    Set tService.Type = "HTTP"
    Set tService.URL = "/fhir/r4"
    Set tSC = tService.%Save()
    Do $System.Status.DisplayError(tSC)
    Quit tSC
}

}
