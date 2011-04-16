Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

###############################

$PSScriptRoot = "d:/PoshScript"

# Mount script folders
New-PSDrive -name psscript -PSProvider FileSystem -Root d:/PoshScript
New-PSDrive -name forks -PSProvider FileSystem -Root d:/Projet/Forks/
New-PSDrive -name poshscript -PSProvider FileSystem -Root "d:/Projet/PowerShell-Scripts/"

# function to include path in powershell path
function poshpath([string] $p) {
    $env:Path = $env:Path + ";$p"
}

# Load scripts
. ./search.ps1
. ./highlight.ps1
. ./touch.ps1
. ./wget.ps1
. ./glassfish-command.ps1
. ./solr.ps1
. ./utils.ps1
. ./prompt.ps1
. ./aliases.ps1

function pro { gvim $profile }

function start-iisexpress () {
	param(
		[string]$port=7070
	);

	#location : use the current folder
	$curr = (Get-Location -PSProvider FileSystem).ProviderPath;

	#start iss
	& 'C:\Program Files\IIS Express\iisexpress.exe' /path:$curr /port:$port
}


# Load Posh Git
Import-Module psscript:/posh-git/posh-git.psm1
# Load module for paske
Import-Module forks:/psake/psake.psm1 

#Set-Alias git D:/Projet/Forks/git-achievements/git-achievements.ps1

poshpath "C:\Program Files\Git\bin"
poshpath "C:\Program Files\GnuWin32\bin"

new-alias -name "g" D:\Projet\Forks\git-achievements\git-achievements.ps1

if(-not (Test-Path Function:\DefaultTabExpansion)) {
    Rename-Item Function:\TabExpansion DefaultTabExpansion
}

# Set up tab expansion and include git expansion
function TabExpansion($line, $lastWord) {
    $lastBlock = [regex]::Split($line, '[|;]')[-1]

    switch -regex ($lastBlock) {
        # Execute git tab completion for all git-related commands
        'git (.*)' { GitTabExpansion $lastBlock }
        # Fall back on existing tab expansion
        default { DefaultTabExpansion $line $lastWord }
    }
}

#clear
cd d:/
