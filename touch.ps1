function touch { 
	param(
		[string] $fil
	)
	
	if (test-path $fil)
	{ 
		Set-ItemProperty -Path $fil -Name LastWriteTime -Value ([DateTime]::Now)
		“File $fil timestamp updated”; 
		return;
	} else {
		Set-Content -Path ($fil) -Value ($null);
		“File $fil created”;
	}
}
