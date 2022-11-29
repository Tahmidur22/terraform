# Terraform

Commands:

Create environment variables to initialise a shared back end (azure storage account)
$env:RESOURCE_GROUP_NAME = 'tchow-state'
$env:STORAGE_ACCOUNT_NAME = 'tchowtfstate'
$env:CONTAINER_NAME = 'tchowtstate'

Create resource group
az group create --name $env:RESOURCE_GROUP_NAME --location uksouth

Create storage account
az storage account create --resource-group $env:RESOURCE_GROUP_NAME --name $env:STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob

Get storage account key
$env:ACCOUNT_KEY = (az storage account keys list --resource-group $env:RESOURCE_GROUP_NAME --account-name $env:STORAGE_ACCOUNT_NAME --query '[0].value' -o tsv)

Create blob container
az storage container create --name $env:CONTAINER_NAME --account-name $env:STORAGE_ACCOUNT_NAME --account-key $env:ACCOUNT_KEY
