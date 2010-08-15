#----------------------------------------------------------------
# Tail.ps1 
# Created by Joe Pruitt : 
# http://devcentral.f5.com/weblogs/Joe/archive/2009/04/22/unix-to-powershell---tail.aspx
#----------------------------------------------------------------

function Tail()
{
	param
	(
		[string]$filespec = $null,
		[int]$num_bytes = -1,
		[int]$num_lines = -1,
		[bool]$follow = $true,
		[int]$sleep = 1,
		[bool]$quiet = $false
	);
	
	# if no bytes or lines specified, default to 10 lines
	if ( (-1 -eq $num_bytes) -and (-1 -eq $num_lines) ) { $num_lines = 10; }
	
	$files = @(Get-ChildItem $filespec);
	foreach ($file in $files)
	{
		# Optionally output file names when multiple files given
		if ( ($files.Length -gt 1) -and !$quiet ) { Write-Host "==> $($file.Name) <=="; }
	
		if ( -1 -ne $num_lines )
		{
			$prev_len = 0;
			while ($true)
			{
				# For line number option, get content as an array of lines
				# and print out the last "n" of them.
				$lines = Get-Content $file;
				
				if ( $prev_len -ne 0 ) { $num_lines = $lines.Length - $prev_len; }
				
				$start_line = $lines.Length - $num_lines;
				
				# Ensure that we don't go past the beginning of the input
				if ( $start_line -le 0 ) { $start_line = 0; }
				
				for ($i = $start_line; $i -lt $lines.Length; $i++)
				{
					$lines[$i];
				}
				$prev_len = $lines.Length;
				
				# If we are following the file, sleep the desired interval
				# else break out of the loop and continue with the next file.
				if ( $follow )
				{
					Start-Sleep $sleep;
				}
				else
				{
					break;
				}
			}
		}
		elseif ( -1 -ne $num_bytes )
		{
			# for num bytes option, get the content as a single string 
			# and substring the last "n" bytes.
			[string]$content = Get-Content $file -delim [char]0;
			
			if ( ($content.Length - $num_bytes) -lt 0 ) { $num_bytes = $content.Length; }
			$content.SubString($content.Length - $num_bytes);
		}
	}
}
