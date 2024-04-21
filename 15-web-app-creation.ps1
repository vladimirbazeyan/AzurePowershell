$resourceGroup="app-storage"
$location="West US"
$appServiceName="demobazeyan5544"
$webAppName="demobazeyanwebapp"


New-AzAppServicePlan -ResourceGroupName $resourceGroup -Location $location `
-Name $appServiceName -Tier "F1"

New-AzWebApp -ResourceGroupName $resourceGroup -Location $location -Name $webAppName -AppServicePlan $appServiceName
