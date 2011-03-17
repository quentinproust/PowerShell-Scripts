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

function get-sln() {
    ls -in *.sln -r | select -first 1 | %{ ii $_.FullName }
}

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


