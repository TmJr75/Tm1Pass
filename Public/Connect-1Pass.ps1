Function Connect-1Pass {
    [CmdletBinding()]
    Param(
    )

    try {
        op signin
        Write-Output "Connected to vault"
    }
    catch {
        Write-Output "Unable to connect to 1pass account"
    }
    

}