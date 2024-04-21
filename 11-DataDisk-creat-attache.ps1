. .\env.ps1
$vmName
$resourceGroup
$diskName

#Create Data Disk

$vm=Get-AzVM -ResourceGroupName $resourceGroup -Name $vmName
$vm | Add-AzVmDataDisk -Name $diskName -DiskSizeInGB 16 -CreateOption Empty -Lun 0 #which one need to attache
$vm | Update-AzVM