. .\env.ps1

New-AzVirtualNetwork -ResourceGroupName $resourceGroup `
-Location $location `
-Name $networkName `
-AddressPrefix $addressPrefix

