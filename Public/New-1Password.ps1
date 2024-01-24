function New-1Password {
    [CmdletBinding()]
    param(
        [ValidateRange(12, 256)]
        [int] 
        $maxLength = 24,
        $minLength = 18,
        [switch]$SecureString
    )

    # Add characters that will be available for the password function
    $symbols = "!@#$%^&*_-".ToCharArray()
    $characterList = [char[]]("a"[0].."z"[0]) + [char[]]("A"[0].."Z"[0]) + "0".."9" + $symbols

    do {

        $length = Get-Random -Minimum $minLength -Maximum $maxLength
        $password = -join (0..$length | % { $characterList | Get-Random })
        
        [int]$hasLowerChar = $password -cmatch '[a-z]'
        [int]$hasUpperChar = $password -cmatch '[A-Z]'
        [int]$hasDigit = $password -match '[0-9]'
        [int]$hasSymbol = $password.IndexOfAny($symbols) -ne -1

    }
    # make sure you atleast have 3 out of 4 check values for password
    until (($hasLowerChar + $hasUpperChar + $hasDigit + $hasSymbol) -ge 3)

    if ($SecureString.IsPresent) {
        $password | ConvertTo-SecureString -AsPlainText -Force
    }
    else {
        $password
    }   
}