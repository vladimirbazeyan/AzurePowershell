. .\env.ps1
#Getting Object VirtualNetowrk
$virtualNetwork=Get-AzVirtualNetwork -Name $networkName -ResourceGroupName $resourceGroup

#Getting Object NetworkSubnetConfig
$subnet=Get-AzVirtualNetworkSubnetConfig -Name $subnetName -VirtualNetwork $virtualNetwork


New-AzNetworkInterface -Name $networkInterfacename `
-ResourceGroupName $resourceGroup `
-Location $location `
#adding subnet ID from $subnet object
-SubnetId $subnet.Id `
-IpConfigurationName "ipConfigapp"