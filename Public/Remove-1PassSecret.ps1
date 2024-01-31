Function Remove-1PassSecret {

<#
.DESCRIPTION
This function removes a credential from your vault based on the Title, Id or Sharelink properties.
.PARAMETER Title
This parameter can be either the Title of your secret, the Id of the secret, or the Sharelink of the secret.
.PARAMETER VaultName
Determines what vault the secret will be removed from.
.SYNOPSIS
Write more soon here
#>
<#
.DESCRIPTION
This function removes a credential from your vault based on the Title, Id or Sharelink properties.
.PARAMETER Title
This parameter can be either the Title of your secret, the Id of the secret, or the Sharelink of the secret.
.PARAMETER VaultName
Determines what vault the secret will be removed from.
.SYNOPSIS
Command to remove secrets from 1password vault.
.EXAMPLE
Remove-1PassSecret -Title xxxxx -VaultName xxxxxxx -Archive
This removes the secret xxxxxx from your vault and puts it in the archive folder
#>




    [CmdletBinding()]
    Param(
        [string][parameter(Mandatory=$true)]$VaultName,
        [string][parameter(Mandatory=$true)]$Title,
        [System.Management.Automation.SwitchParameter]$Archive

    )

    if ($Archive) {
        try {
            Write-Output "Trying to remove secret: $Title Vault: $VaultName"
            op item delete $Title --vault $VaultName --archive
        }
        catch {
            Write-Output "Unable to remove secret: $Title  Vault: $VaultName"
        }
    }
    else {
        try {
            Write-Output "Trying to remove secret: $Title Vault: $VaultName"
            op item delete $Title --vault $VaultName
        }
        catch {
            Write-Output "Unable to remove secret: $Title  Vault: $VaultName"
        }
    }

    

}