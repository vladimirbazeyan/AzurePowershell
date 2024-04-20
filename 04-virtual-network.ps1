. .\env.ps1 # adding env variables from env file
#. .\03-virtual-network.ps1 #adding object $virtualNetwork

#Remove Virtual Network
Remove-AzVirtualNetwork -Name $networkName -ResourceGroupName $resourceGroup

$VirtualNetwork=New-AzVirtualNetwork -ResourceGroupName $resourceGroup -Location $location -Name $networkName -AddressPrefix $addressPrefix
write-host $VirtualNetwork.AddressSpace.AddressPrefixes
write-host $VirtualNetwork.Location
