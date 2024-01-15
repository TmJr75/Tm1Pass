Function New-1PassSecret {
    [cmdletBinding()]
    param(
        [parameter(Mandatory="True")][string]$Title,
        [parameter(Mandatory="True")][string]$VaultName, 
        [parameter(Mandatory="True")][string]$UserName,
        # [parameter(Mandatory="True")][securestring]$Password, 
        [parameter(Mandatory="False")][string]$url,
        [parameter(Mandatory="Tags")][string]$tags
    )

    $password = Read-Host -Prompt "Please enter your password" -AsSecureString
    # Check if Credential exist based on Title / UserName and VaultName
    # Add checks for the different params to create a new cred, cli does not handle missing params too well.
    Write-Output "Checking for existing credential"
    $Exists = Get-1passCredential -Title $Title -VaultName $VaultName
    $Exists.length

    if ($exists.username.length -gt 0) {
        Write-Output "Secret already exists, do you wish to create a duplicate?"
    }
    else {

        $credObject = New-Object -TypeName pscredential -ArgumentList $UserName,$Password

        Write-Output "Secret does not exist, adding secret"
        $newCred = op item create `
        --category login `
        --title "$title" `
        --vault $vaultName `
        --url $url `
        --tags $tags `
        "username=$userName" `
        "password=$($credObject.GetNetworkCredential().Password)"

        return $newCred
    }
    
}