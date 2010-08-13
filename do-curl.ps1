# Function CURL
# Used for requesting a web resource.

param 
(
    [string]$url = $null
);

function Do-Curl() 
{
    param(
        [string]$url = $null
    );

    trap [Exception] { 
        write $("ERREUR : " + $_.Exception.Message); 
        continue; 
    }

	if($url -ne $null) {
		$client = $client = (new-object net.webclient)
		$resource = $client.DownloadString($url)
		Write $resource
	}
}