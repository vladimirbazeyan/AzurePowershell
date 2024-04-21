# Resource Groupe
# Location
# $networkSecuritGroupName="app-nsg"
Connect-AzAccount
#loading variables from env file
. .\env.ps1

#Creating rule for network security group
$nsgrule1=New-AzNetworkSecurityRuleConfig -Name "Allow-rdp" -Access Allow -Protocol Tcp `
-Direction Inbound -Priority 120 -SourceAddressPrefix internet -SourcePortRange * `
-DestinationAddressPrefix 10.0.0.0/24 -DestinationPortRange 3389

$nsgrule2=New-AzNetworkSecurityRuleConfig -Name "Allow-80" -Access Allow -Protocol Tcp `
-Direction Inbound -Priority 130 -SourceAddressPrefix internet -SourcePortRange * `
-DestinationAddressPrefix 10.0.0.0/24 -DestinationPortRange 80

#it isnt attached to any subnet or network interface
New-AzNetworkSecurityGroup -Name $networkSecuritGroupName -Location $location -ResourceGroupName $resourceGroup `
-SecurityRules $nsgrule1, $nsgrule2


