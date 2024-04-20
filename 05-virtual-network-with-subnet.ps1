. .\env.ps1 # adding env variables from env file
#. .\03-virtual-network.ps1 #adding object $virtualNetwork

$VirtualNetwork=Get-AzVirtualNetwork -Name $networkName -ResourceGroupName $resourceGroup


write-host $VirtualNetwork.AddressSpace.AddressPrefixes
write-host $VirtualNetwork.Location


#this is adding subnet prefix to the $VirtualNetwork object localy
Add-AzVirtualNetworkSubnetConfig -Name $subnetName -VirtualNetwork $VirtualNetwork -AddressPrefix $subnetAddressPrefix

#Setting subnet to network
$VirtualNetwork | Set-AzVirtualNetwork
