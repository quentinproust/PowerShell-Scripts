# Find-String.ps1
#  Wrapper around dir | select-string which will highlight the pattern in the results

# Write the line with the pattern highlighted in red
function Highlight()
{
	param	( [string] $pattern = ""
	, [string] $filter = "*.*"
	, [switch] $recurse = $false
	, [switch] $caseSensitive = $false);
	begin {
		if ($pattern -eq $null -or $pattern -eq "") { Write-Error "Please provide a search pattern!" ; return }

		$regexPattern = $pattern
		if($caseSensitive -eq $false) { $regexPattern = "(?i)$regexPattern" }
		$regex = New-Object System.Text.RegularExpressions.Regex $regexPattern
	}
	process {
		$inputText = $_;
		$index = 0
		while($index -lt $inputText.Length)
		{
			$match = $regex.Match($inputText, $index)
			if($match.Success -and $match.Length -gt 0)
			{
				Write-Host $inputText.SubString($index, $match.Index - $index) -nonewline
				Write-Host $match.Value.ToString() -ForegroundColor Red -nonewline
				$index = $match.Index + $match.Length
			}
			else
			{
				Write-Host $inputText.SubString($index) -nonewline
				$index = $inputText.Length
			}
		}
		Write-Host ""
	}
}