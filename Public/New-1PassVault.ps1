Function New-1PassVault {
    [CmdletBinding()]
    Param([string][parameter(Mandatory=$true)]$vaultName)


    # Check if vault exists from before
    $vaultList = Get-1passVault


    # if vault does not exist, create vault.
    if ($vaultList.name -contains $vaultName) {
        Write-Output "Vault already exists!"
    }
    else {
        try {
            op vault create $vaultName | ConvertFrom-Json
        }
        catch {
            Write-Output "Unable to create vault: $vault"
            throw error[0]
        }
    
    }

}