Function Get-1PassCredential {
    [cmdletBinding()]
    param(
        [parameter(Mandatory="True")][string]$title,
        [string]$vaultName
    )

    try {
        if ($vaultName) {
            $credObject = op item get $title --vault $vaultName | convertfrom-Json
        }
        else {
            $credObject = op item get $title | ConvertFrom-Json
        }
    }
    catch {
        Write-Output "Unable to get secret with title: $title"
    }
    

    New-Object -TypeName PSCredential `
        -ArgumentList (($credObject.fields | where-object {$_.Type -like "String" -and $_.purpose -like "UserName"}).value), 
            (($($credObject.fields | where-object {$_.Type -like "Concealed" -and $_.purpose -like "Password"}).value | convertTo-SecureString -asPlainText -Force))
    
}