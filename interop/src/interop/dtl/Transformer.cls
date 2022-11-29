Class interop.dtl.Transformer Extends Ens.DataTransformDTL [ DependsOn = (Demo.RecordMap.Map.Delimited.Record, HS.FHIR.DTL.vR4.Model.Resource.Patient) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='Demo.RecordMap.Map.Delimited.Record' targetClass='HS.FHIR.DTL.vR4.Model.Resource.Patient' create='new' language='objectscript' >
<assign value='source.LastName' property='target.name.(1).family' action='set' />
<assign value='source.FirstName' property='target.name.(1).given.(1)' action='set' />
<assign value='source.HomeAddress.City' property='target.address.(1).city' action='set' />
<assign value='source.HomeAddress.State' property='target.address.(1).state' action='set' />
<assign value='source.HomeAddress.ZipCode' property='target.address.(1).postalCode' action='set' />
</transform>
}

}
