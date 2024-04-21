$resourceGroup="app-grp"
$location="West US"
$networkName="app-network"
$addressPrefix="10.0.0.0/16"
$subnetName="SubnetA"
$subnetAddressPrefix="10.0.0.0/24"
$networkInterfacename="app-net-interface"
$publicIpAddress="pub-ip"
$networkSecuritGroupName="app-nsg"

#VM Name & Size
$vmName="appvm1"
$vmSize="Standard_DS2_v2"

#data disk
$diskName="app-data-disk"



#Creating Resource Group
New-AzResourceGroup -Name $resourceGroup -Location $location


#Creating Virtual Network

#Creating object SubnetConfig
$subnet=New-AzVirtualNetworkSubnetConfig -Name $subnetName -AddressPrefix $subnetAddressPrefix
#Creating Virtual Network with subnet object
$publicIpaddress=New-AzVirtualNetwork -ResourceGroupName $resourceGroup -Location $location -Name $networkName -AddressPrefix $addressPrefix -Subnet $subnet


#adding Public IP Address
New-AzPublicIpAddress -Name $publicIpAddress -ResourceGroupName $resourceGroup -Location $location -AllocationMethod Static


#Getting Object VirtualNetowrk
$virtualNetwork=Get-AzVirtualNetwork -Name $networkName -ResourceGroupName $resourceGroup
#Getting Object NetworkSubnetConfig
$subnet=Get-AzVirtualNetworkSubnetConfig -Name $subnetName -VirtualNetwork $virtualNetwork


$networkinterface=New-AzNetworkInterface -Name $networkInterfacename -ResourceGroupName $resourceGroup -Location $location -SubnetId $subnet.Id -IpConfigurationName "ipConfigapp"


#Attache public IP address to network interface
#Network interface needs to be attached to ipconfig on network interface
$ipconfig=Get-AzNetworkInterfaceIpConfig -NetworkInterface $networkinterface
$networkinterface | Set-AzNetworkInterfaceIpConfig -PublicIpAddress $publicIpAddress -Name $ipconfig.Name
$networkinterface | Set-AzNetworkInterface 


#Creating NSG
#Creating rule for network security group object
$nsgrule1=New-AzNetworkSecurityRuleConfig -Name "Allow-rdp" -Access Allow -Protocol Tcp `
-Direction Inbound -Priority 120 -SourceAddressPrefix internet -SourcePortRange * `
-DestinationAddressPrefix 10.0.0.0/24 -DestinationPortRange 3389

$nsgrule2=New-AzNetworkSecurityRuleConfig -Name "Allow-80" -Access Allow -Protocol Tcp `
-Direction Inbound -Priority 130 -SourceAddressPrefix internet -SourcePortRange * `
-DestinationAddressPrefix 10.0.0.0/24 -DestinationPortRange 80

#it isnt attached to any subnet or network interface
$networksecuritygroup=New-AzNetworkSecurityGroup -Name $networkSecuritGroupName -Location $location -ResourceGroupName $resourceGroup `
-SecurityRules $nsgrule1, $nsgrule2

#Attache the NSG to the subnet
Set-AzVirtualNetworkSubnetConfig -Name $subnetName -VirtualNetwork $virtualNetwork `
-NetworkSecurityGroup $networksecuritygroup -AddressPrefix $addressPrefix

$virtualNetwork | Set-AzVirtualNetwork


#Creating Virtual machin
#    $vmName="appvm1"
#    $vmSize="Standard_DS2_v2"
# To get available VM Sizes execut
    Get-AzVMSize -Location 'West US' 
#

#creating windows credentials for VM
$Credential=Get-Credential

#vmConfig object
$vmConfig=New-AzVMConfig -VMName $vmName -VMSize $vmSize


#setting  OS to VMconfig
Set-AzVMOperatingSystem -VM $vmConfig -ComputerName $vmName -Credential $Credential -Windows

#setting  SourceImage to vm confing
Set-AzVMSourceImage -VM $vmConfig -PublisherName "MicrosoftWindowsServer" `
-Offer "WindowsServer" -Skus "2022-Datacenter" -Version "latest"

$networkInterface=Get-AzNetworkInterface -Name $networkInterfacename -ResourceGroupName $resourceGroup

$vm=Add-AzVMNetworkInterface -VM $vmConfig -Id $networkInterface.Id

Set-AzVMBootDiagnostic -Disable -Vm $vm

New-AzVM -ResourceGroupName $resourceGroup -Location $location -VM $vm
