### Define variables
{
$location = 'Australia Southeast'
$resourceGroupName = 'rc-simple-iaas-template'
$resourceDeploymentName = 'rc-arm-iaas-template-deployment'
$templatePath = "\\tsclient\azure-share\azure-resource-manager-deep-dive\"
$templateFile = 'rc_simpleIaas.json'
$template = $templatePath + '\' + $templateFile
}

### Create Resource Group
{
New-AzureRmResourceGroup `
    -Name $resourceGroupName `
    -Location $Location `
    -Verbose -Force
}

### Deploy Resources
{
New-AzureRmResourceGroupDeployment `
    -Name $resourceDeploymentName `
    -ResourceGroupName $resourceGroupName `
    -TemplateFile $template `
    -Verbose -Force
}