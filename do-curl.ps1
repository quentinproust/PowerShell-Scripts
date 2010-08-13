# Function CURL
# Used for requesting a web resource.
function Do-Curl([string] $url) {

    trap [Exception] { 
        write $("ERREUR : " + $_.Exception.Message); 
        continue; 
    }

    $client = $client = (new-object net.webclient)
    $resource = $client.DownloadString($url)
    Write $resource
}