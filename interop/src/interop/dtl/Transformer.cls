Class interop.dtl.Transformer Extends Ens.DataTransformDTL [ DependsOn = (interop.msg.DummyLog, HS.FHIR.DTL.vR4.Model.Resource.Patient) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='interop.msg.DummyLog' targetClass='HS.FHIR.DTL.vR4.Model.Resource.Patient' create='new' language='objectscript' >
<assign value='"family"' property='target.name.(1).family' action='set' />
<assign value='"given"' property='target.name.(1).given.(1)' action='set' />
<assign value='"female"' property='target.gender' action='set' />
<assign value='"12/25/2001"' property='target.birthDate' action='set' />
<assign value='"city1"' property='target.address.(1).city' action='set' />
<assign value='"state1"' property='target.address.(1).state' action='set' />
<assign value='12345' property='target.address.(1).postalCode' action='set' />
<assign value='"country1"' property='target.address.(1).country' action='set' />
<assign value='"single"' property='target.maritalStatus' action='set' />
</transform>
}

}
