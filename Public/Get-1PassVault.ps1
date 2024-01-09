Function Get-1PassVault {
    [CmdletBinding()]
    Param()

    # List vaults in your OnePass account

    try {
        op vault list | ConvertFrom-Json
    }
    catch {
        write-Output "Unable to access vaults"
        throw $error[0]
    }
}