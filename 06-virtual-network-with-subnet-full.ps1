. .\env.ps1



$subnet=New-AzVirtualNetworkSubnetConfig -Name $subnetName -AddressPrefix $subnetAddressPrefix

New-AzVirtualNetwork -ResourceGroupName $resourceGroup `
-Location $location `
-Name $networkName `
-AddressPrefix $addressPrefix `
-Subnet $subnet

