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

    Set tService = ##class(HS.Registry.Service.HTTP).%New()
    Set tService.Host = "fhir.8xugujg2l938.workload-prod-fhiraas.isccloud.io"
    Set tService.Name = "external-fhirserver-oauth"
    //Set tService.Port= 443
    Set tService.SSLConfig = "ISC.FeatureTracker.SSL.Config"
    Set tService.Type = "HTTP"
    Set tService.URL = "/oauth2"
    Set tSC = tService.%Save()
    Do $System.Status.DisplayError(tSC)

    Set tService = ##class(HS.Registry.Service.HTTP).%New()
    Set tService.Host = "fhir.8xugujg2l938.workload-prod-fhiraas.isccloud.io"
    Set tService.Name = "external-simple-service"
    //Set tService.Port= 443
    Set tService.SSLConfig = "ISC.FeatureTracker.SSL.Config"
    Set tService.Type = "HTTP"
    Set tService.URL = ""
    Set tSC = tService.%Save()
    Do $System.Status.DisplayError(tSC)

    Quit tSC
}

}
