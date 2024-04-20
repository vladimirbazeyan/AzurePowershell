. .\env.ps1

$VirtualNetwork=Get-AzVirtualNetwork -Name $networkName -ResourceGroupName $resourceGroup

# $virtualNetwork is an object that has his own properties
#$VirtualNetwork.AddressSpace

write-host $VirtualNetwork.AddressSpace.AddressPrefixes
write-host $VirtualNetwork.Location


