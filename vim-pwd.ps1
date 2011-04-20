function vimpwd([string] $path) {
  $result = "";
  $path = $path.Substring($path.IndexOf(":\")+ 2);
 
  if([String]::IsNullOrEmpty($path)) {return ""}

  $parts = $path.Split("\");
  if($parts.Count -gt 0) {
    foreach ($p in $parts) {
      $firstLetter = $p.Substring(0,1).ToLower() 
      $result = "$result/$firstLetter"
    }
  }
  return $result;
}
