. .\env.ps1

$virtualNetwork=Get-AzVirtualNetwork -Name $networkName -ResourceGroupName $resourceGroup
$subnet=Get-AzVirtualNetworkSubnetConfig -Name $subnetName -VirtualNetwork $virtualNetwork

New-AzNetworkInterface -Name $networkInterfacename `
-ResourceGroupName $resourceGroup `
-Location $location `
-SubnetId $subnet.Id `
-IpConfigurationName "ipConfigapp"