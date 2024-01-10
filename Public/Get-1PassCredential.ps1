Function Get-1PassCredential {
    [cmdletBinding()]
    param(
        [parameter(Mandatory="True")][string]$title,
        [string]$vaultName
    )

    try {
        if ($vaultName) {
            op item get $title --vault $vaultName | convertfrom-Json -depth 10
        }
        else {
            op item get $title | ConvertFrom-Json -depth 10
        }
    }
    catch {
        Write-Output "Unable to get secret with title: $title"
    }
    

    
}