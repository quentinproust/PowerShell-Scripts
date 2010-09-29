# Function CURL
# Used for requesting a web resource.
#
###########################################################
# PARAMETERS
# Url : Url of the request resource
# Method : Http verb used (GET,POST,PUT,DELETE,HEAD)
# Auth : If you need to use Http Authentication.
#        -auth "your-username"
#        The password is requested by the script latter
#        so it cannot be read.
#

function Do-Curl() 
{
param 
(
    [string]$url = $null,
	[string]$method = "GET",
	[string]$auth = $null
);

    trap [Exception] { 
        write $("ERREUR : " + $_.Exception.Message); 
        continue; 
    }
  
    if($url -ne $null) {
    
        # Create a new request
		$webrequest = [system.Net.HttpWebRequest]::create($url);
        $webrequest.set_Method($method);

		$shouldAuth = ! ([boolean] [String]::IsNullOrEmpty($auth));
        if($shouldAuth) {
            $pass = Read-Host -assecurestring "Please enter your password"
            $credentials = new-object System.Net.NetworkCredential ($auth, $pass);
            $webrequest.set_Credentials($credentials);
        }

		# Get the response
		$response = [system.Net.HttpWebResponse] $webrequest.GetResponse();

		# Get the response stream and read it completely
		$stream = $response.GetResponseStream();
		$reader = new-object io.StreamReader($stream);
		$resource = $reader.ReadToEnd();

		# Write response 
		Write $resource;
	}
}
