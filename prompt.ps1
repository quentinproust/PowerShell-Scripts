# Set up a simple prompt, adding the git prompt parts inside git repos

. ./vim-pwd.ps1

function prompt {
  $p = $pwd.ToString();
  $path = $p.SubString($p.LastIndexOf("\") + 1);
  $drive = $p.SubString(0,$p.IndexOf(":")).ToLower();

  $vimlike = vimpwd($p);

  Write-Host ("$drive"+": ")  -nonewline -foregroundcolor Green;
  Write-Host $vimlike    -nonewline -foregroundcolor Blue; 
  Write-Host " $path"    -nonewline -foregroundcolor Green;

# Git Prompt
  $Global:GitStatus = Get-GitStatus;
  Write-GitStatus $GitStatus;

  Write-Host;
  return "> ";
}


