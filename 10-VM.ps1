#Creating Virtual machin
. .\env.ps1
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


