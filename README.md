 [![Gitter](https://img.shields.io/badge/Available%20on-Intersystems%20Open%20Exchange-00b2a9.svg)](https://openexchange.intersystems.com/package/iris-fhir-app)
 [![Quality Gate Status](https://community.objectscriptquality.com/api/project_badges/measure?project=intersystems_iris_community%2Firis-fhirserver&metric=alert_status)](https://community.objectscriptquality.com/dashboard?id=intersystems_iris_community%2Firis-fhirserver)
 [![Reliability Rating](https://community.objectscriptquality.com/api/project_badges/measure?project=intersystems_iris_community%2Firis-fhirserver&metric=reliability_rating)](https://community.objectscriptquality.com/dashboard?id=intersystems_iris_community%2Firis-fhirserver)
# iris-fhir-app
This is my first FHIR app. It contains a FHIR SERVER, imports test data, and demoes REST API usage with a simple web page.

I added an Interoperability Production which can transform a RecordMap to FHIR. It sends new patients to the FHIR SERVER.

## Prerequisites
Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.

## Installation 

Clone/git pull the repo into any local directory

```
$ git clone https://github.com/oliverwilms/iris-fhirserver.git
```

Open the terminal in this directory and run:

```
$ docker-compose up -d
```

## Online Demo
You can find online demo here - [Production Configuration](https://iris-fhirserver.demo.community.intersystems.com/csp/healthshare/fhirinterop/EnsPortal.ProductionConfig.zen?PRODUCTION=interop.Production) or 
[Management Portal](https://iris-fhirserver.demo.community.intersystems.com/csp/sys/UtilHome.csp) or 
[FHIR UI Demo](https://iris-fhirserver.demo.community.intersystems.com/csp/user/fhirUI/FHIRAppDemo.html) or 
[FHIR Server metadata](https://iris-fhirserver.demo.community.intersystems.com/fhir/r4/metadata)

## Patient data
The template provides several patients in [/data/fhir](https://github.com/intersystems-community/iris-fhir-server-template/tree/master/data/fhir) folder which are automatically loaded. To generate more patients, open terminal shell in repository folder and call:
```
#./synthea-loader.sh 10
```
This will create 10 more patients in data/fhir folder.
Then open IRIS terminal in FHIRSERVER namespace with the following command:
```
docker-compose exec iris iris session iris -U FHIRServer
```
and call the loader method:
```
FHIRSERVER>d ##class(fhirtemplate.Setup).LoadPatientData("/irisdev/app/output/fhir","FHIRSERVER","/fhir/r4")
```

 with using the [following project](https://github.com/intersystems-community/irisdemo-base-synthea)

## Transform RecordMap to FHIR

Copy recordmap sample file to fhir-input directory inside the container 
```
cp /opt/irisapp/delimited/RecordMap_Delimited_TX.txt /opt/irisapp/fhir-input/TX.txt
```

The EnsLib.RecordMap.Service.FileService sends the file to interop.bp.Transformer where the RecordMap record is transformed to FHIR. You should be able to find the patient in FHIRSERVER.

## Testing FHIR R4 API

Open URL http://localhost:32783/fhir/r4/metadata
you should see the output of fhir resources on this server

## Testing Postman calls
Get fhir resources metadata
GET call for http://localhost:32783/fhir/r4/metadata
<img width="881" alt="Screenshot 2020-08-07 at 17 42 04" src="https://user-images.githubusercontent.com/2781759/89657453-c7cdac00-d8d5-11ea-8fed-71fa8447cc45.png">


Open Postman and make a GET call for the preloaded Patient:
http://localhost:32783/fhir/r4/Patient/1
<img width="884" alt="Screenshot 2020-08-07 at 17 42 26" src="https://user-images.githubusercontent.com/2781759/89657252-71606d80-d8d5-11ea-957f-041dbceffdc8.png">


## Testing FHIR API calls in simple frontend APP

the very basic frontend app with search and get calls to Patient and Observation FHIR resources could be found here:
http://localhost:32783/csp/user/fhirUI/FHIRAppDemo.html
or from VSCode ObjectScript menu:
<img width="616" alt="Screenshot 2020-08-07 at 17 34 49" src="https://user-images.githubusercontent.com/2781759/89657546-ea5fc500-d8d5-11ea-97ed-6fbbf84da655.png">

While open the page you will see search result for female anemic patients and graphs a selected patient's hemoglobin values:
<img width="484" alt="Screenshot 2020-08-06 at 18 51 22" src="https://user-images.githubusercontent.com/2781759/89657718-2b57d980-d8d6-11ea-800f-d09dfb48f8bc.png">

## How to start development
This repository is ready to code in VSCode with ObjectScript plugin.
Install [VSCode](https://code.visualstudio.com/), [Docker](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker) and [ObjectScript](https://marketplace.visualstudio.com/items?itemName=daimor.vscode-objectscript) plugin and open the folder in VSCode.
Open /src/cls/PackageSample/ObjectScript.cls class and try to make changes - it will be compiled in running IRIS docker container.
![docker_compose](https://user-images.githubusercontent.com/2781759/76656929-0f2e5700-6547-11ea-9cc9-486a5641c51d.gif)

Feel free to delete PackageSample folder and place your ObjectScript classes in a form
/src/Package/Classname.cls
[Read more about folder setup for InterSystems ObjectScript](https://community.intersystems.com/post/simplified-objectscript-source-folder-structure-package-manager)

The script in Installer.cls will import everything you place under /src into IRIS.


## What's inside the repository

### Dockerfile

The simplest dockerfile which starts IRIS and imports Installer.cls and then runs the Installer.setup method, which creates IRISAPP Namespace and imports ObjectScript code from /src folder into it.
Use the related docker-compose.yml to easily setup additional parametes like port number and where you map keys and host folders.
Use .env/ file to adjust the dockerfile being used in docker-compose.


### .vscode/settings.json

Settings file to let you immedietly code in VSCode with [VSCode ObjectScript plugin](https://marketplace.visualstudio.com/items?itemName=daimor.vscode-objectscript))

### .vscode/launch.json
Config file if you want to debug with VSCode ObjectScript


## Troubleshooting
**ERROR #5001: Error -28 Creating Directory /usr/irissys/mgr/FHIRSERVER/**
If you see this error it probably means that you ran out of space in docker.
you can clean up it with the following command:
```
docker system prune -f
```
And then start rebuilding image without using cache:
```
docker-compose build --no-cache
```
and start the container with:
```
docker-compose up -d
```

This and other helpful commands you can find in [dev.md](https://github.com/intersystems-community/iris-fhir-template/blob/cd7e0111ff94dcac82377a2aa7df0ce5e0571b5a/dev.md)
