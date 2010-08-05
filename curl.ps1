# Faire un curl
#$null = ""
#Load System.web assembly
#[reflection.assembly]::loadwithpartialname("system.net") > $null

function CurlURL([string] $url) {

    trap [Exception] { 
        write $("ERREUR : " + $_.Exception.Message); 
        continue; 
    }

    $client = $client = (new-object net.webclient)
    $resource = $client.DownloadString($url)
    Write $resource
}

CurlURL $args[0] 