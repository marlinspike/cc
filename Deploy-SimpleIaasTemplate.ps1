### Define variables
{
$location = 'West Central US'
$resourceGroupName = 'ccnet_resources_new'
$resourceDeploymentName = 'ccnet'
$templatePath = "\\tsclient\azure-share\CloudConcierge-ARM-Template"
$templateFile = 'rc_simpleIaas.json'
$template = $templatePath + '\' + $templateFile

#Set up VM Passwords
$vm_jumpbox_password = "Pres_jumpbox_1234#"
$vm_jumpbox_secure_password = $vm_jumpbox_password | ConvertTo-SecureString -AsPlainText -Force

$vm_web_password = "Pres_web_1234#"
$vm_web_secure_password = $vm_web_password | ConvertTo-SecureString -AsPlainText -Force

$vm_conductor_password = "Pres_conductor_1234#"
$vm_conductor_secure_password = $vm_conductor_password | ConvertTo-SecureString -AsPlainText -Force

$vm_db_password = "Pres_db_1234#"
$vm_db_secure_password = $vm_db_password | ConvertTo-SecureString -AsPlainText -Force

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
$additionalParameters['vm_webAdminPassword'] = $vm_web_secure_password
$additionalParameters['vm_conductorAdminPassword'] = $vm_conductor_secure_password
$additionalParameters['vm_dbAdminPassword'] = $vm_db_secure_password

New-AzureRmResourceGroupDeployment `
    -Name $resourceDeploymentName `
    -ResourceGroupName $resourceGroupName `
    -TemplateFile $template `
	@additionalParameters ` 
    -Verbose -Force
}