# Set up a simple prompt, adding the git prompt parts inside git repos
function prompt {
    $path = $pwd.ToString().SubString($pwd.ToString().LastIndexOf("\") + 1)
    $drive = $pwd.ToString().SubString(0,1).ToLower() 
    
    Write-Host("$drive"+":"+ "$path") -nonewline -foregroundcolor Green 

    # Git Prompt
    $Global:GitStatus = Get-GitStatus
    Write-GitStatus $GitStatus

    Write-Host
    return "> "
}


