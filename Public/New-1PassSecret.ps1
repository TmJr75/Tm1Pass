Function Get-1PassSecret {
    [cmdletBinding()]
    param(
        [parameter(Mandatory="True")][string]$title,
        [string]$vaultName
    )

    try {
        if ($vaultName) {
            $object = op item get $title --vault $vaultName | convertfrom-Json
            return $object
        }
        else {
            $object = op item get $title | ConvertFrom-Json
            return $object
        }
    }
    catch {
        # Write-Output "Unable to get secret with title: $title"
        throw "Unable to get secret: $title"
    }
    
}