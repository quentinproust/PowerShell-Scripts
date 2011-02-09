Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

###############################

$PSScriptRoot = "d:/PoshScript"

# Mount script folders
New-PSDrive -name psscript -PSProvider FileSystem -Root d:/PoshScript

# function to include path in powershell path
function poshpath([string] $p) {
    $env:Path = $env:Path + ";$p"
}

# Load scripts
#. ./do-tail.ps1
. ./search.ps1
#. ./curl.ps1
. ./highlight.ps1
. ./touch.ps1
. ./wget.ps1
New-Alias -Name sudo 'psscript:\Sudo.ps1'
# Load Posh Growl
. psscript:/Send-Growl3.0.ps1

# Load Posh Git
Import-Module psscript:/posh-git/posh-git.psm1
#Set-Alias git D:/Projet/Forks/git-achievements/git-achievements.ps1


# Alias
#set-alias grep select-string;

# Helper Functions
#function strip-extension ([string] $filename) { 
#	[system.io.path]::getfilenamewithoutextension($filename)
#}

#function ssh () {
#	& 'C:\Program Files\Git\bin\ssh.exe' $args[0]
#}

#function curl () { & 'C:\Program Files\Git\bin\curl.exe' $args }
#function tail () { & 'C:\Program Files\Git\bin\tail.exe' $args }
#function grep () { & 'C:\Program Files\Git\bin\grep.exe' $args }

poshpath "C:\Program Files\Git\bin"
poshpath "C:\Program Files\GnuWin32\bin"

function fsi () { & 'C:\Program Files\Microsoft F#\v4.0\Fsi.exe' $args[0] }

function here () {ii .}
function oshell () {ii C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe }

function ms () { 
    if($args[0] -eq $null) {
       ls *.sln | % {C:/Windows/Microsoft.NET/Framework/v4.0.30319/MSBuild.exe $_.Name}
    } else {
        C:/Windows/Microsoft.NET/Framework/v4.0.30319/MSBuild.exe $args[0]
    }
}

# Adding some function for glassfish server
function gf () {
#GlassFish directory
    $bin = "D:\Work\Tools\glassfish\bin\"
    $log = "D:\Work\Tools\glassfish\domains\domain1\logs\"

    function execBat([string] $bat) {
        $file = [String]::concat($bin, $bat)
        cmd /c $file
    }


    if($args[0].equals("start")) {
        Write "Starting glassfish server"
        execBat "asadmin.bat start-domain domain1"
        
        Send-Growl-Easy Glassfish Start "Glassfish state changed" "Glassfish has been succesfully started"
    } elseif($args[0].equals("stop")) {
        Write "Stopping glassfish server"
        execBat "asadmin.bat stop-domain domain1"
    Send-Growl-Easy Glassfish Start "Glassfish state changed" "Glassfish has been succesfully stop"

    } elseif($args[0].equals("restart")) {
        Write "Restarting glassfish server"
        Write "Stopping glassfish server"
        execBat "asadmin.bat stop-domain domain1"
        Write "Starting glassfish server"
        execBat "asadmin.bat start-domain domain1"

    Send-Growl-Easy Glassfish Start "Glassfish state changed" "Glassfish has been succesfully restarted"

    } elseif($args[0].equals("tail")) {
        $logFile = [String]::concat($log, "server.log")
        Write $logFile
        tail -f $logFile 
    }

}

function solr () {
    $query = $args[0]
    curl "http://localhost:8080/solr/select/?q=$query&indent=on&wt=json"
}


#$emacsRun = d:/work/tools/emacs/emacs-23.2/bin/runemacs.exe
#$emacsClient = d:/work/tools/emacs/emacs-23.2/bin/emacsclientw.exe
#$emacsInit = d:/work/tools/.emacs
#function emacs () {
#	 if ( (ps | Where{$_.Name.Contains("emacs")}) -eq $n"ull ) {
#	    $emacsRun -q -l $emacsInit $args[0];
#	 } else {
#	    $emacsClient -q -l $emacsInit $args[0];
#	 }
#}


# Go location
#if( $GLOBAL:go_locations -eq $null ) {
#$GLOBAL:go_locations = @{};
#}
#function go ([string] $location) {
#	if( $go_locations.ContainsKey($location) ) {
#		set-location $go_locations[$location];
#	} else {
#		write-output "The following locations are defined:";
#		write-output $go_locations;
#	}
#}
#$go_locations.Add("home", "~")
#$go_locations.Add("work", "d:/work/")
#$go_locations.Add("tools", "d:/work/tools")
#$go_locations.Add("srm", "d:/work/srmvision/sources/")

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

# Set up a simple prompt, adding the git prompt parts inside git repos
function prompt {
    $path = $pwd.ToString().SubString($pwd.ToString().LastIndexOf("\") + 1)
    $drive = $pwd.ToString().SubString(0,1).ToLower() 
    
    Write-Host("$drive"+":"+ "$path") -nonewline

    # Git Prompt
    $Global:GitStatus = Get-GitStatus
    Write-GitStatus $GitStatus

    Write-Host
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
#go home
clear
cd d:/
