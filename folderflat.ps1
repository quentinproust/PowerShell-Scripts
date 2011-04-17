# arg[0] : extension to filter
# arg[1] : new folder

$ext = $args[0]
$folder = $args[1]

if((Test-Path $folder) -eq $False) {
    mkdir $folder
}

ls -recurse -filter "*.$ext" | % {
    cp $_.FullName "$folder/$_"
}
