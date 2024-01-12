Function Get-1PassCredential {
    [cmdletBinding()]
    param(
        [parameter(Mandatory="True")][string]$title,
        [string]$vaultName, 
        [switch]$Clipboard
    )

    try {
        if ($vaultName) {
            $credObject = op item get $title --vault $vaultName | convertfrom-Json

            $credential = New-Object -TypeName PSCredential `
            -ArgumentList (($credObject.fields | where-object {$_.Type -like "String" -and $_.purpose -like "UserName"}).value), 
                (($($credObject.fields | where-object {$_.Type -like "Concealed" -and $_.purpose -like "Password"}).value | convertTo-SecureString -asPlainText -Force))

            return $credential
        
        if ($Clipboard) {
            $credential.GetNetworkCredential().password | Set-Clipboard
        }
    
        }
        else {
            $credObject = op item get $title | ConvertFrom-Json

            $credential = New-Object -TypeName PSCredential `
            -ArgumentList (($credObject.fields | where-object {$_.Type -like "String" -and $_.purpose -like "UserName"}).value), 
                (($($credObject.fields | where-object {$_.Type -like "Concealed" -and $_.purpose -like "Password"}).value | convertTo-SecureString -asPlainText -Force))

            return $credential
        
        if ($Clipboard) {
            $credential.GetNetworkCredential().password | Set-Clipboard
        }
    
        }
    }
    catch {
        Write-Output "Unable to get secret with title: $title"
    }
    

}