function wget() {

	param(
		[string]$url = $null,
		[string]$file = $null
	);

	$client = (new-object net.webclient);

	if ((test-path $file))
    {
		$ok = Read-Host "The file already exist. Do you want to override it ? (yes / no)";
		if(!($ok.StartWith("y"))) { return; }
	} 
	$client.DownloadFile($url, $file);
	Write "The file $file have been downloaded successfully";
}
