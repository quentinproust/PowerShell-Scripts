function touch { 
	param(
		[string] $fil
	)
	
	if (test-path $fil)
	{ 
		Set-ItemProperty -Path $fil -Name LastWriteTime -Value ([DateTime]::Now)
		echo "File $fil timestamp updated"; 
		return;
	} else {
		Set-Content -Path ($fil) -Value ($null);
		echo "File $fil created";
	}
}
