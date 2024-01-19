Function Get-1PassVaultSecret {
    [CmdletBinding()]
    Param([string][parameter(Mandatory=$false)]$vaultName)

    $env:OP_FORMAT = "json"


    # List credentials stored in specific vault

    if ($vaultName) {
        $credList = op item list --vault $vaultName | ConvertFrom-Json
        return $credList
    }
    else {
        $credList = op item list | convertfrom-Json
        return $credList
    }
    
    
}