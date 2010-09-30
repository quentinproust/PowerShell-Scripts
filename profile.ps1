Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

# Alias
set-alias grep select-string;

# Helper Functions
function strip-extension ([string] $filename) { 
	[system.io.path]::getfilenamewithoutextension($filename)
}

function emacs () {
	d:/work/tools/emacs/emacs-23.2/bin/runemacs.exe $args[0];
}

# Go location
if( $GLOBAL:go_locations -eq $null ) {
$GLOBAL:go_locations = @{};
}
function go ([string] $location) {
	if( $go_locations.ContainsKey($location) ) {
		set-location $go_locations[$location];
	} else {
		write-output "The following locations are defined:";
		write-output $go_locations;
	}
}
$go_locations.Add("home", "~")
$go_locations.Add("work", "d:/work/")
$go_locations.Add("tools", "d:/work/tools")
$go_locations.Add("srm", "d:/work/srmvision/sources/")

############################## ????
# LS.MSH 
# Colorized LS function replacement 
# /\/\o\/\/ 2006 
# http://mow001.blogspot.com 
function LL
{
    param ($dir = ".", $all = $false) 

    $origFg = $host.ui.rawui.foregroundColor 
    if ( $all ) { $toList = ls -force $dir }
    else { $toList = ls $dir }

    foreach ($Item in $toList)  
    { 
        Switch ($Item.Extension)  
        { 
			".ps1" {$host.ui.rawui.foregroundColor = "Cyan"} 
            ".Exe" {$host.ui.rawui.foregroundColor = "Yellow"} 
            ".cmd" {$host.ui.rawui.foregroundColor = "Red"} 
            ".msh" {$host.ui.rawui.foregroundColor = "Red"} 
            ".vbs" {$host.ui.rawui.foregroundColor = "Red"} 
            Default {$host.ui.rawui.foregroundColor = $origFg} 
        } 
        if ($item.Mode.StartsWith("d")) {$host.ui.rawui.foregroundColor = "Green"}
        $item 
    }  
    $host.ui.rawui.foregroundColor = $origFg 
}

function lla
{
    param ( $dir=".")
    ll $dir $true
}

function la { ls -force }

###############################

# Load scripts
. ./do-tail.ps1
. ./search.ps1
. ./curl.ps1
. ./highlight.ps1
. ./touch.ps1
. ./wget.ps1

# Load Posh Git
Import-Module ../posh-git/posh-git.psm1

Pop-Location

# Set up a simple prompt, adding the git prompt parts inside git repos
function prompt {
    Write-Host($pwd) -nonewline

    # Git Prompt
    $Global:GitStatus = Get-GitStatus
    Write-GitStatus $GitStatus

    return "> "
}

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

# Return to home
go home