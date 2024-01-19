Function Get-1PassCredential {
    [CmdletBinding()]
    Param(
        [parameter(Mandatory = $true)][string]$title,
        [string]$vaultName, 
        [switch]$Clipboard
    )

    $env:OP_FORMAT = "json"



    # try {
        if ($vaultName) {
            # Write-Output "VaultName"
            $credObject = op item get $title --vault $vaultName | convertfrom-Json
            # $credObject.length
            
            if (!$null -eq $credObject) {
                
                $returnValue = New-Object -TypeName PSCredential -ArgumentList (($credObject.fields | where-object { $_.Type -like "String" -and $_.id -like "UserName" }).value), (($credObject.fields | where-object { $_.Type -like "Concealed" -and $_.id -like "Password" }).value | convertTo-SecureString -asPlainText -Force)

            
                
                if ($Clipboard) {
                    $returnValue.GetNetworkCredential().password | Set-Clipboard
                    return $returnValue

                }
                else {
                    # Write-Output "Return Cred1:"
                    return $returnValue
                }
                
            }
            else {
                Write-Output "Multiple credentials found, nothing to return"
                Write-Output "Credential Count: $($credObject.count)"
            }
            


        }
        else {
            # Write-Output "No VaultName"
            $credObject = op item get $title | ConvertFrom-Json
            # Write-Output "Finished getting credential2"
            if (!$null -eq $credObject) {
                $returnValue = New-Object -TypeName PSCredential -ArgumentList (($credObject.fields | where-object { $_.Type -like "String" -and $_.purpose -like "UserName" }).value), (($credObject.fields | where-object { $_.Type -like "Concealed" -and $_.purpose -like "Password" }).value | convertTo-SecureString -asPlainText -Force)
        
                if ($Clipboard) {
                    $returnValue.GetNetworkCredential().password | Set-Clipboard
                    return $returnValue

                }
                else {
                    # Write-Output "Return Cred1:"
                    return $returnValue
                }
                # Write-Output "Return Cred2:"
                # Write-Output "Credential value: $credential"

            }
            else {
                Write-Output "Multiple credentials found, nothing to return"
                Write-Output "Credential Count: $($credObject.count)"
            }
        }
 #   }
 #    catch {
  #       Throw $error[0]
  #   }
    

}