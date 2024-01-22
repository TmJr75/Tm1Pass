Function Get-1PassVaultSecret {
    [CmdletBinding()]
    Param([string][parameter(Mandatory=$false)]$vaultName)

    $env:OP_FORMAT = "json"


    # List credentials stored in specific vault
    # create a PSPropertySet with the default property names
  [string[]]$visible = 'Id','Title','Category, Tags'
  [Management.Automation.PSMemberInfo[]]$visibleProperties = [System.Management.Automation.PSPropertySet]::new('DefaultDisplayPropertySet',$visible)
   
  # before outputting, append the PSStandardMembers property:

    if ($vaultName) {
        $credList = op item list --vault $vaultName | ConvertFrom-Json
        $credList |
        Add-Member -MemberType MemberSet -Name PSStandardMembers -Value $visibleProperties -PassThru
      
        return $credList
    }
    else {
        $credList |
        Add-Member -MemberType MemberSet -Name PSStandardMembers -Value $visibleProperties -PassThru
      
        $credList = op item list | convertfrom-Json
        return $credList
    }
    
    
}