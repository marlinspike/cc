### Define variables
{
$location = 'Australia Southeast'
$resourceGroupName = 'ccnet_resources_new'
$resourceDeploymentName = 'ccnet'
$templatePath = "\\tsclient\azure-share\CloudConcierge-ARM-Template"
$templateFile = 'rc_simpleIaas.json'
$template = $templatePath + '\' + $templateFile
$vm_jumpbox_password = "Pres_jumpbox_1234#"
$vm_jumpbox_secure_password = $vm_jumpbox_password | ConvertTo-SecureString -AsPlainText -Force
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
$additionalParameters = New-Object -TypeName Hashtable
$additionalParameters['vm_jumpboxAdminPassword'] = $vm_jumpbox_secure_password

New-AzureRmResourceGroupDeployment `
    -Name $resourceDeploymentName `
    -ResourceGroupName $resourceGroupName `
    -TemplateFile $template `
	@additionalParameters ` 
    -Verbose -Force
}