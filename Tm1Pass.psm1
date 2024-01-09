
<#
. TestModule7 
#>

Get-ChildItem -Path $PSScriptRoot\*.ps1 -Exclude *.tests.ps1, *profile.ps1 -Recurse | 
ForEach-Object {
	. $_.FullName
}

$env:OP_FORMAT = "json"

# Enable auto complete for PowerShell
op completion powershell | Out-String | Invoke-Expression
