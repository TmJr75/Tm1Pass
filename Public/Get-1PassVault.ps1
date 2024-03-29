Function Get-1PassVault {
    [CmdletBinding()]
    Param()

    $env:OP_FORMAT = "json"

    # List vaults in your OnePass account

    try {
        $object = op vault list | ConvertFrom-Json
        return $object
    }
    catch {
        write-Output "Unable to access vaults"
        throw $error[0]
    }
}