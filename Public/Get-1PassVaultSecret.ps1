Function Get-1PassVaultSecret {
    [CmdletBinding()]
    Param([string][parameter(Mandatory=$false)]$vaultName)

    # List credentials stored in specific vault

    if ($vaultName) {
        $credList = op item list --vault $vaultName | ConvertFrom-Json
    }
    else {
        $credList = op item list | convertfrom-Json
    }
    
    return $credList
}