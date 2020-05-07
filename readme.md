---
services: app-service\api
platforms: dotnet
author: bradygaster
---

# To Do List Azure API App Sample #

This is a simple example that demonstrates how to build and consume [API apps](http://azure.microsoft.com/en-us/documentation/articles/app-service-api-apps-why-best-platform/ "What are API Apps?") in Azure App Service. This example application uses a Web API middle tier API app, a Web API data tier API app, and an AngularJS client web app front end.  

This sample is used in the [getting-started series of tutorials for API apps](http://azure.microsoft.com/documentation/articles/app-service-api-dotnet-get-started/). These tutorials show how to use API metadata, how to configure CORS, how to configure user authentication, and how to handle internal access using an Azure Active Directory service account.

To deploy the application to your Azure subscription without following the tutorial, use the **Deploy to Azure** button.

[![Deploy to Azure](http://azuredeploy.net/deploybutton.png)](https://azuredeploy.net/)

# Azure Cloud Shell Deployment

In order to deploy this via Cloud Shell, you'll need to set up a couple of variables prior to starting. This can be done in `~/.bashrc`, but remember to source it prior to running the script, with `. ~/.bashrc`. Note that this will happen on your next login, but won't take effect if you've just changed it in the current session. 

Variables required prior to starting:

```
WEBAPP_USER=ryanmaclean # EXAMPLE, DON'T USE!
WEBAPP_PASS=cr4zyaw3someP4ss? # EXAMPLE, DON'T USE!
```

These can be added to `~/.bashrc` (or `~/.zshrc` for zsh!) by using nano or vim (both are installed by default in Azure Cloud Shell).

Once added, make sure to `source` the file in order to load the variables like so: `source ~/.bashrc`. 

The script is in the repo as `cloud_shell_script.sh`, but the contents are here in case you simply want to copy/paste. Note that you want to edit the location, SKU, etc prior to running it. : 

```
#SET VARIABLES
RESOURCE_GROUP=myResourceGroup
LOCATION="East US2"
APP_NAME=myAppTest
APP_PLAN=myAppServicePlan
SKU=FREE

#CREATE RESOURCES
az webapp deployment user set --user-name "$WEBAPP_USER" --password "$WEBAPP_PASS"
az group create --name "$RESOURCE_GROUP" --location "$LOCATION"
az appservice plan create --name "$APP_PLAN" --resource-group "$RESOURCE_GROUP" --sku "$SKU"
sleep 30
az webapp create --resource-group "$RESOURCE_GROUP" --plan "$APP_PLAN" --name "$APP_NAME" --deployment-local-git

#CLONE CODE THEN PUSH TO SITE
cd ~
mkdir $APP_NAME
cd $APP_NAME
git clone https://github.com/ryanmaclean/dotnet-core-api
cd dotnet-core-api
git remote add azure https://"$WEBAPP_USER"@"$APP_NAME".scm.azurewebsites.net/"$APP_NAME".git
git push azure master
```
