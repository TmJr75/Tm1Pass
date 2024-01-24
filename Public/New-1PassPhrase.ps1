Function New-1PassPhrase  {
    [CmdletBinding()]
    Param([int][Parameter(Mandatory=$false)]$minLength=24)
    #wordlist: https://websites.umich.edu/~jlawler/wordlist
    # Ensure capital first letter
    $textinfo = (get-culture).textinfo

    # Write-Output $PSScriptRoot
    $dictionary = get-content $PSScriptRoot\wordlist.txt
    # Write-Output "Dictionary:"
    # $dictionary.length

    if ($dictionary.Length -gt 0) {
        $splitWord = "A", "We", "Us", "And", "Or", "Now", "Then", "They", "Are", "By", "Next", "To"

    $passPhrase = $textinfo.ToTitleCase((get-random -inputObject $dictionary)) + " " +  $textinfo.ToTitleCase((get-random -InputObject $splitWord)) + " " + $textinfo.ToTitleCase((get-random -InputObject $dictionary))

    while ($passPhrase.Length -lt $minLength) {

        $passPhrase = $textinfo.ToTitleCase((get-random -inputObject $dictionary)) + 
            " " +  
            $textinfo.ToTitleCase((get-random -InputObject $splitWord)) + " " +
            $textinfo.ToTitleCase((get-random -InputObject $dictionary)) + " " + 
            $textinfo.ToTitleCase((get-random -inputobject $splitWord))
    }
        return $passPhrase
    }
    else {
        Write-Output "Not able to find dictionary, unable to create passphrase"
    }

    
}