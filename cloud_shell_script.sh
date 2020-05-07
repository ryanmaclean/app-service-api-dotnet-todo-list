#! /usr/bin/env bash

set -euo pipefail

#SET VARIABLES - YOU'LL WANT TO CHANGE ALL OF THESE MOST LIKELY
RESOURCE_GROUP=myResourceGroup
LOCATION="East US2"
APP_NAME=myAppTest
APP_PLAN=myAppServicePlan
SKU=FREE

#CREATE RESOURCES
az webapp deployment user set --user-name "$WEBAPP_USER" --password "$WEBAPP_PASS"
az group create --name "$RESOURCE_GROUP" --location "$LOCATION"
az appservice plan create --name "$APP_PLAN" --resource-group "$RESOURCE_GROUP" --sku "$SKU"
sleep 30 #TODO - FIGURE OUT A WAY TO QUERY THAT THIS EXISTS _AND_ WORKS
az webapp create --resource-group "$RESOURCE_GROUP" --plan "$APP_PLAN" --name "$APP_NAME" --deployment-local-git

#CLONE CODE IN HOME FOLDER, THEN PUSH TO SITE
cd ~
mkdir $APP_NAME
cd $APP_NAME
git clone https://github.com/ryanmaclean/dotnet-core-api
cd dotnet-core-api
git remote add azure https://"$WEBAPP_USER"@"$APP_NAME".scm.azurewebsites.net/"$APP_NAME".git
git push azure master
