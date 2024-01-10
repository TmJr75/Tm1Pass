Function Get-1PassCredential {
    [cmdletBinding()]
    param(
        [parameter(Mandatory="True")][string]$title,
        [string]$vaultName
    )

    try {
        if ($vaultName) {
            op item get $title --vault $vaultName | convertfrom-Json
        }
        else {
            op item get $title | ConvertFrom-Json
        }
    }
    catch {
        Write-Output "Unable to get secret with title: $title"
    }
    

    
}