$resourceGroup="app-storage"
$location="West US"
$accountSKU="Standard_LRS"
$accountName="bazeyanqaqstorage"
$storageAccountKind="storageV2"

New-AzResourceGroup -Name $resourceGroup -Location $location

New-AzStorageAccount -Name $accountName -SkuName $accountSKU -Kind $storageAccountKind  -ResourceGroupName $resourceGroup -Location $location
